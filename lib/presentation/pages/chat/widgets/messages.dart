import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../domain/enums/message_type.dart';
import '../../../../domain/models/message/message.dart';
import '../../../bl/chat/chat_page_messages_cubit.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  static final DateFormat _dateFormat = DateFormat('dd MMMM');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageMessagesCubit, DataState<FetchFailure, DataPage<Message>>>(
      builder: (BuildContext context, DataState<FetchFailure, DataPage<Message>> state) {
        return state.maybeWhen(
          success: (DataPage<Message> data) {
            return _SliverGroupedListView<Message, DateTime>(
              elements: data.items,
              groupBy: (Message e) => DateTime(
                e.createdAt!.year,
                e.createdAt!.month,
                e.createdAt!.day,
              ),
              groupSeparatorBuilder: (DateTime date) =>
                  Align(child: Text(_dateFormat.format(date))),
              itemBuilder: (_, __, Message message) {
                switch (message.type) {
                  case MessageType.text:
                  case MessageType.voice:
                  case MessageType.video:
                  case MessageType.image:
                  case MessageType.gif:
                  case MessageType.unknown:
                    return Align(
                      alignment: message.isOwn ? Alignment.centerRight : Alignment.centerLeft,
                      child: _MessageWrapper(message: message),
                    );
                }
              },
              extraItemBuilder: data.items.length < data.count
                  ? (_) => const Center(
                        child: CircularProgressIndicator(),
                      )
                  : null,
              onExtraItemBuilt: data.items.length < data.count
                  ? context.read<ChatPageMessagesCubit>().onScrolledToEnd
                  : null,
            );
          },
          orElse: () => const SliverToBoxAdapter(),
        );
      },
    );
  }
}

class _TextMessage extends StatelessWidget {
  const _TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      constraints: BoxConstraints(
        maxWidth: mediaQueryData.size.width * .6,
      ),
      decoration: BoxDecoration(
        color: message.isOwn ? theme.colorScheme.secondary : theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(6),
          topRight: const Radius.circular(6),
          bottomRight: message.isOwn ? Radius.zero : const Radius.circular(6),
          bottomLeft: message.isOwn ? const Radius.circular(6) : Radius.zero,
        ),
      ),
      child: Text(
        message.textMessage ?? '',
        style: TextStyle(
          color: message.isOwn ? Colors.white : null,
        ),
      ),
    );
  }
}

class _SliverGroupedListView<T, E> extends StatelessWidget {
  const _SliverGroupedListView({
    Key? key,
    required this.elements,
    required this.groupBy,
    required this.itemBuilder,
    this.groupSeparatorBuilder,
    this.groupHeaderBuilder,
    this.separator = const SizedBox.shrink(),
    this.extraItemBuilder,
    this.onExtraItemBuilt,
  })  : assert(groupSeparatorBuilder != null || groupHeaderBuilder != null),
        super(key: key);

  final List<T> elements;
  final E Function(T element) groupBy;
  final Widget Function(BuildContext context, int index, T element) itemBuilder;

  final Widget Function(E value)? groupSeparatorBuilder;
  final Widget Function(T element)? groupHeaderBuilder;
  final Widget separator;

  final WidgetBuilder? extraItemBuilder;
  final VoidCallback? onExtraItemBuilt;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == elements.length * 2) {
            onExtraItemBuilt?.call();
            return extraItemBuilder!.call(context);
          }

          final int actualIndex = index ~/ 2;
          if (index.isEven) {
            return itemBuilder(
              context,
              actualIndex,
              elements[actualIndex],
            );
          }

          final E curr = groupBy(elements[actualIndex]);
          E? next;
          if (actualIndex + 1 < elements.length) {
            next = groupBy(elements[actualIndex + 1]);
          }

          if (next == null || next != curr) {
            return _buildGroupSeparator(elements[actualIndex]);
          }

          return separator;
        },
        childCount: elements.length * 2 + (extraItemBuilder != null ? 1 : 0),
      ),
    );
  }

  Widget _buildGroupSeparator(T element) {
    if (groupHeaderBuilder == null) {
      return groupSeparatorBuilder!(groupBy(element));
    }
    return groupHeaderBuilder!(element);
  }
}

class _MessageWrapper extends StatefulWidget {
  const _MessageWrapper({
    Key? key,
    required this.message,
    this.dateFormat,
  }) : super(key: key);

  final Message message;
  final DateFormat? dateFormat;

  static final DateFormat _defaultDateFormat = DateFormat('dd/MM hh:mm');

  @override
  _MessageWrapperState createState() => _MessageWrapperState();
}

class _MessageWrapperState extends State<_MessageWrapper> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    final CurvedAnimation parent = CurvedAnimation(parent: _controller, curve: Curves.ease);

    _slideAnimation = Tween<double>(
      begin: 0,
      end: -15,
    ).animate(parent);

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(parent);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget messageChild;

    switch (widget.message.type) {
      case MessageType.text:
      case MessageType.voice:
      case MessageType.video:
      case MessageType.image:
      case MessageType.gif:
      case MessageType.unknown:
        messageChild = _TextMessage(message: widget.message);
        break;
    }

    return Align(
      alignment: widget.message.isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => _controller.isCompleted ? _controller.reverse() : _controller.forward(),
        child: AnimatedBuilder(
          animation: _slideAnimation,
          builder: (_, Widget? child) {
            return Padding(
              padding: EdgeInsets.only(top: _slideAnimation.value.abs()),
              child: child,
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                bottom: 0,
                right: widget.message.isOwn ? 12 : null,
                left: widget.message.isOwn ? null : 12,
                child: AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (_, Widget? child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: child,
                    );
                  },
                  child: Text(
                    (widget.dateFormat ?? _MessageWrapper._defaultDateFormat)
                        .format(widget.message.createdAt!),
                    style: TextStyle(fontSize: 12, color: theme.secondaryHeaderColor),
                  ),
                ),
              ),
              // widget.child,
              AnimatedBuilder(
                animation: _slideAnimation,
                builder: (_, Widget? child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: child,
                  );
                },
                child: messageChild,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
