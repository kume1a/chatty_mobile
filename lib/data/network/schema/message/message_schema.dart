import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/image_meta_schema.dart';

part 'message_schema.freezed.dart';

part 'message_schema.g.dart';

@freezed
class MessageSchema with _$MessageSchema {
  const factory MessageSchema({
    int? id,
    int? userId,
    int? chatId,
    String? type,
    String? textMessage,
    String? imageFilePath,
    String? videoFilePath,
    String? voiceFilePath,
    String? filePath,
    String? gifUrl,
    String? createdAt,
    ImageMetaSchema? imageMeta,
  }) = _MessageSchema;

  factory MessageSchema.fromJson(Map<String, dynamic> json) => _$MessageSchemaFromJson(json);
}
