import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_schema.freezed.dart';

part 'chat_schema.g.dart';

@freezed
class ChatSchema with _$ChatSchema {
  const factory ChatSchema({
    int? id,
    String? createdAt,
  }) = _ChatSchema;

  factory ChatSchema.fromJson(Map<String, dynamic> json) => _$ChatSchemaFromJson(json);
}
