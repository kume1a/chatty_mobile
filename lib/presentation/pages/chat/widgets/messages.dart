import 'dart:math';

import 'package:common_models/common_models.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants.dart';
import '../../../../domain/enums/message_type.dart';
import '../../../../domain/models/message/message_wrapper.dart';
import '../../../bl/chat/chat_page_cubit.dart';
import '../../../bl/chat/chat_page_messages_cubit.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  static final DateFormat _dateFormat = DateFormat('dd MMMM');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageMessagesCubit, DataState<FetchFailure, DataPage<MessageWrapper>>>(
      builder: (BuildContext context, DataState<FetchFailure, DataPage<MessageWrapper>> state) {
        return state.maybeWhen(
          success: (DataPage<MessageWrapper> data) {
            return _SliverGroupedListView<MessageWrapper, DateTime>(
              elements: data.items,
              groupBy: (MessageWrapper e) => e.message?.createdAt != null
                  ? DateTime(
                      e.message!.createdAt!.year,
                      e.message!.createdAt!.month,
                      e.message!.createdAt!.day,
                    )
                  : DateTime.now(),
              groupSeparatorBuilder: (DateTime date) =>
                  Align(child: Text(_dateFormat.format(date))),
              itemBuilder: (_, __, MessageWrapper messageWrapper) => Align(
                alignment: messageWrapper.message?.isOwn == true
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: _MessageWrapper(messageWrapper: messageWrapper),
              ),
              extraItemBuilder: data.items.length < data.count
                  ? (_) => const Center(child: CircularProgressIndicator())
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

class _SliverGroupedListView<T, E> extends StatelessWidget {
  const _SliverGroupedListView({
    super.key,
    required this.elements,
    required this.groupBy,
    required this.itemBuilder,
    this.groupSeparatorBuilder,
    this.groupHeaderBuilder,
    this.separator = const SizedBox.shrink(),
    this.extraItemBuilder,
    this.onExtraItemBuilt,
  }) : assert(groupSeparatorBuilder != null || groupHeaderBuilder != null);

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
    required this.messageWrapper,
  });

  final MessageWrapper messageWrapper;

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
    if (widget.messageWrapper.message == null) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);

    final Widget messageChild;

    switch (widget.messageWrapper.message!.type) {
      case MessageType.text:
      case MessageType.voice:
      case MessageType.video:
      case MessageType.gif:
      case MessageType.file:
      case MessageType.unknown:
        messageChild = _TextMessage(messageWrapper: widget.messageWrapper);
        break;
      case MessageType.image:
        messageChild = _ImageMessage(messageWrapper: widget.messageWrapper);
        break;
    }

    return GestureDetector(
      onTap: () {
        _controller.isCompleted ? _controller.reverse() : _controller.forward();
        context.read<ChatPageCubit>().onMessagePressed(widget.messageWrapper.message);
      },
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
            if (widget.messageWrapper.message!.createdAt != null)
              Positioned(
                bottom: 0,
                right: widget.messageWrapper.message!.isOwn ? 12 : null,
                left: widget.messageWrapper.message!.isOwn ? null : 12,
                child: AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (_, Widget? child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: child,
                    );
                  },
                  child: Text(
                    _MessageWrapper._defaultDateFormat
                        .format(widget.messageWrapper.message!.createdAt!),
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
    );
  }
}

class _TextMessage extends StatelessWidget {
  const _TextMessage({
    required this.messageWrapper,
  });

  final MessageWrapper messageWrapper;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    final Color backgroundColor;
    if (messageWrapper.message!.isOwn) {
      if (messageWrapper.failure == null) {
        backgroundColor = messageWrapper.isSent
            ? theme.colorScheme.secondary
            : theme.colorScheme.secondary.withOpacity(.5);
      } else {
        backgroundColor = theme.colorScheme.error;
      }
    } else {
      backgroundColor = theme.colorScheme.secondaryContainer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      constraints: BoxConstraints(
        maxWidth: mediaQueryData.size.width * .6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(6),
          topRight: const Radius.circular(6),
          bottomRight: messageWrapper.message!.isOwn ? Radius.zero : const Radius.circular(6),
          bottomLeft: messageWrapper.message!.isOwn ? const Radius.circular(6) : Radius.zero,
        ),
      ),
      child: Text(
        messageWrapper.message!.textMessage ?? '',
        style: TextStyle(
          color: messageWrapper.message!.isOwn ? Colors.white : null,
        ),
      ),
    );
  }
}

class _ImageMessage extends StatelessWidget {
  const _ImageMessage({
    required this.messageWrapper,
  });

  final MessageWrapper messageWrapper;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    Widget image;
    if (messageWrapper.isSent) {
      image = SafeImage(
        url: Constants.apiUrl + (messageWrapper.message!.imageFilePath ?? ''),
        placeholderColor: theme.colorScheme.secondaryContainer,
      );
    } else {
      image = messageWrapper.inMemoryImage != null
          ? Image.memory(messageWrapper.inMemoryImage!)
          : ColoredBox(color: theme.colorScheme.secondaryContainer);
    }

    final double base = mediaQueryData.size.width * .6;
    final int imageWidth = messageWrapper.message!.imageMeta?.width ?? 0;
    final int imageHeight = messageWrapper.message!.imageMeta?.height ?? 0;
    final double scale = (max(imageWidth, imageHeight) / 1280).clamp(0, 1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      constraints: BoxConstraints.tight(Size(
        (scale * imageWidth).clamp(base / 2, base),
        (scale * imageHeight).clamp(base / 2, base),
      )),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: image,
    );
  }
}
