import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_schema.freezed.dart';

part 'message_schema.g.dart';

@freezed
class MessageSchema with _$MessageSchema {
  const factory MessageSchema({
    int? id,
    String? type,
    String? textMessage,
    String? imageUrl,
    String? videoUrl,
    String? gifUrl,
    String? createdAt,
  }) = _MessageSchema;

  factory MessageSchema.fromJson(Map<String, dynamic> json) => _$MessageSchemaFromJson(json);
}
