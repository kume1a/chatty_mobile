import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/chat/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../mappers/chat/chat_mapper.dart';
import '../mappers/chat/chats_page_mapper.dart';
import '../network/remote_services/chat_remote_service.dart';
import '../network/schema/chat/chat_schema.dart';
import '../network/schema/chat/chats_page_schema.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(
    this._chatRemoteService,
    this._chatsPageMapper,
    this._chatMapper,
  );

  final ChatRemoteService _chatRemoteService;
  final ChatsPageMapper _chatsPageMapper;
  final ChatMapper _chatMapper;

  @override
  Future<Either<FetchFailure, DataPage<Chat>>> getChats({
    required int? lastId,
  }) async {
    final Either<FetchFailure, ChatsPageSchema> result = await _chatRemoteService.getChats(
      lastId: lastId,
      takeCount: 15,
    );

    if (result.isRight()) {
      final DataPage<Chat> mapped = await _chatsPageMapper.mapToRight(result.rightOrThrow);

      return right(mapped);
    }
    return left(result.leftOrThrow);
  }

  @override
  Future<Either<FetchFailure, Chat>> getChatByUserId({
    required int userId,
  }) async {
    final Either<FetchFailure, ChatSchema> result =
        await _chatRemoteService.getChatByUserId(userId: userId);

    if (result.isRight()) {
      final Chat mapped = await _chatMapper.mapToRight(result.rightOrThrow);

      return right(mapped);
    }
    return left(result.leftOrThrow);
  }
}
