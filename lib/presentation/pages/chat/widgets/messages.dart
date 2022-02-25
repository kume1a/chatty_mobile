import 'dart:math';

import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/message/message.dart';
import '../../../bl/chat/chat_page_messages_cubit.dart';

final Random random = Random();

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
            itemBuilder: (_, int index) => _TextMessage(message: data.items[index]),
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

    final bool isOwn = random.nextBool();

    return Align(
      alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: mediaQueryData.size.width * .6,
        ),
        decoration: BoxDecoration(
          color: isOwn ? theme.colorScheme.secondary : theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(6),
            topRight: const Radius.circular(6),
            bottomRight: isOwn ? Radius.zero : const Radius.circular(6),
            bottomLeft: isOwn ? const Radius.circular(6) : Radius.zero,
          ),
        ),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          style: TextStyle(
            color: isOwn ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
