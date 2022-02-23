import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_schema.dart';

part 'chats_page_schema.freezed.dart';

part 'chats_page_schema.g.dart';

@freezed
class ChatsPageSchema with _$ChatsPageSchema {
  const factory ChatsPageSchema({
    List<ChatSchema>? data,
    int? count,
  }) = _ChatsPageSchema;

  factory ChatsPageSchema.fromJson(Map<String, dynamic> json) => _$ChatsPageSchemaFromJson(json);
}
