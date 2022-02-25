import 'package:common_models/common_models.dart';
import 'package:common_network_components/common_network_components.dart';
import 'package:injectable/injectable.dart';

import '../api/api_service.dart';
import '../schema/chat/chat_schema.dart';
import '../schema/chat/chats_page_schema.dart';

@lazySingleton
class ChatRemoteService extends BaseService {
  ChatRemoteService(
    this._apiService,
  );

  final ApiService _apiService;

  Future<Either<FetchFailure, ChatsPageSchema>> getChats({
    required int? lastId,
    required int takeCount,
  }) async =>
      safeFetch(() => _apiService.getChats(lastId, takeCount));

  Future<Either<FetchFailure, ChatSchema>> getChatByUserId({
    required int userId,
  }) async =>
      safeFetch(() => _apiService.getChatByUserId(userId));
}
