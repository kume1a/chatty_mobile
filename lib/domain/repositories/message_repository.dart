import 'dart:typed_data';

import 'package:common_models/common_models.dart';

import '../models/message/message.dart';

abstract class MessageRepository {
  Future<Either<SimpleActionFailure, Message>> sendMessage({
    required int chatId,
    String? textMessage,
    Uint8List? imageFile,
  });

  Future<Either<FetchFailure, DataPage<Message>>> getMessages({
    required int chatId,
    required int? lastId,
  });
}
