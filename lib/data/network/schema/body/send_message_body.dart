import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message_body.freezed.dart';

part 'send_message_body.g.dart';

@freezed
class SendMessageBody with _$SendMessageBody {
  const factory SendMessageBody({
    required int chatId,
    String? textMessage,
  }) = _SendMessageBody;

  factory SendMessageBody.fromJson(Map<String, dynamic> json) => _$SendMessageBodyFromJson(json);
}
