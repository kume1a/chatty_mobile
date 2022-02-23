import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/chat/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../mappers/chat/chats_page_mapper.dart';
import '../network/remote_services/chat_remote_service.dart';
import '../network/schema/chat/chats_page_schema.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(
    this._chatRemoteService,
    this._chatsPageMapper,
  );

  final ChatRemoteService _chatRemoteService;
  final ChatsPageMapper _chatsPageMapper;

  @override
  Future<Either<FetchFailure, DataPage<Chat>>> getChats({
    required int? lastId,
  }) async {
    final Either<FetchFailure, ChatsPageSchema> result = await _chatRemoteService.getChats(
      lastId: lastId,
      takeCount: 15,
    );

    return result.map((ChatsPageSchema r) => _chatsPageMapper.mapToRight(r));
  }
}
