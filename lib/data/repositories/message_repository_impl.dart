import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/message/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../mappers/message/message_mapper.dart';
import '../mappers/message/messages_page_mapper.dart';
import '../network/remote_services/message_remote_service.dart';
import '../network/schema/message/message_schema.dart';
import '../network/schema/message/messages_page_schema.dart';

@LazySingleton(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  MessageRepositoryImpl(
    this._messageRemoteService,
    this._messageMapper,
    this._messagesPageMapper,
  );

  final MessageRemoteService _messageRemoteService;
  final MessageMapper _messageMapper;
  final MessagesPageMapper _messagesPageMapper;

  @override
  Future<Either<FetchFailure, DataPage<Message>>> getMessages({
    required int chatId,
    required int? lastId,
  }) async {
    final Either<FetchFailure, MessagesPageSchema> result = await _messageRemoteService.getMessages(
      chatId: chatId,
      lastId: lastId,
      takeCount: 20,
    );

    if (result.isRight()) {
      final DataPage<Message> mapped = await _messagesPageMapper.mapToRight(result.rightOrThrow);

      return right(mapped);
    }

    return left(result.leftOrThrow);
  }

  @override
  Future<Either<SimpleActionFailure, Message>> sendMessage({
    required int chatId,
    String? textMessage,
  }) async {
    final Either<SimpleActionFailure, MessageSchema> result =
        await _messageRemoteService.sendMessage(
      chatId: chatId,
      textMessage: textMessage,
    );

    if (result.isRight()) {
      final Message mapped = await _messageMapper.mapToRight(result.rightOrThrow);

      return right(mapped);
    }

    return left(result.leftOrThrow);
  }
}
