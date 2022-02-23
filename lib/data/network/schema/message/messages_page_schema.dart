import 'package:freezed_annotation/freezed_annotation.dart';

import 'message_schema.dart';

part 'messages_page_schema.freezed.dart';

part 'messages_page_schema.g.dart';

@freezed
class MessagesPageSchema with _$MessagesPageSchema {
  const factory MessagesPageSchema({
    List<MessageSchema>? data,
    int? count,
  }) = _MessagesPageSchema;

  factory MessagesPageSchema.fromJson(Map<String, dynamic> json) =>
      _$MessagesPageSchemaFromJson(json);
}
