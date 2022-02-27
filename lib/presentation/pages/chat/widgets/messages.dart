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
                    return _TextMessage(message: message);
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

    return Align(
      alignment: message.isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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
