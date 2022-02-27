import 'package:common_models/common_models.dart';

import '../models/chat/chat.dart';

abstract class ChatRepository {
  Future<Either<FetchFailure, DataPage<Chat>>> getChats({
    required int? page,
  });

  Future<Either<FetchFailure, Chat>> getChatByUserId({
    required int userId,
  });
}
