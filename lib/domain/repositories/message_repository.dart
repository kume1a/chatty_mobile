import 'package:common_models/common_models.dart';

import '../models/message/message.dart';
import '../../core/named_file.dart';

abstract class MessageRepository {
  Future<Either<SimpleActionFailure, Message>> sendMessage({
    required int chatId,
    required String sendId,
    String? textMessage,
    NamedFile? imageFile,
    NamedFile? file,
  });

  Future<Either<FetchFailure, DataPage<Message>>> getMessages({
    required int chatId,
    required int? lastId,
  });
}
