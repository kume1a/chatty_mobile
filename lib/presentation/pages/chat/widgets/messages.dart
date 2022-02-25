import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/enums/message_type.dart';
import '../../../../domain/models/message/message.dart';
import '../../../bl/chat/chat_page_messages_cubit.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageMessagesCubit, DataState<FetchFailure, DataPage<Message>>>(
      builder: (BuildContext context, DataState<FetchFailure, DataPage<Message>> state) {
        return state.maybeWhen(
          success: (DataPage<Message> data) => ListView.builder(
            itemCount: data.items.length,
            reverse: true,
            itemBuilder: (_, int index) {
              final Message message = data.items[index];

              switch (message.type) {
                case MessageType.text:
                case MessageType.voice:
                case MessageType.video:
                case MessageType.image:
                case MessageType.gif:
                case MessageType.unknown:
                  return _TextMessage(message: data.items[index]);
              }
            },
          ),
          orElse: () => const SizedBox.shrink(),
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
