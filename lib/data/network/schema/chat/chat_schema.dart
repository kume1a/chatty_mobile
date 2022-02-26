import 'package:freezed_annotation/freezed_annotation.dart';

import '../message/message_schema.dart';
import '../user/user_schema.dart';

part 'chat_schema.freezed.dart';

part 'chat_schema.g.dart';

@freezed
class ChatSchema with _$ChatSchema {
  const factory ChatSchema({
    int? id,
    String? createdAt,
    UserSchema? user,
    MessageSchema? lastMessage,
  }) = _ChatSchema;

  factory ChatSchema.fromJson(Map<String, dynamic> json) => _$ChatSchemaFromJson(json);
}
