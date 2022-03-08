import 'package:freezed_annotation/freezed_annotation.dart';

import '../../enums/message_type.dart';
import '../common/image_meta.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required int id,
    required int userId,
    required int chatId,
    required MessageType type,
    String? textMessage,
    String? imageFilePath,
    String? videoFilePath,
    String? voiceFilePath,
    String? gifUrl,
    required DateTime? createdAt,
    required bool isOwn,
    ImageMeta? imageMeta,
  }) = _Message;
}
