import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/message/message_wrapper.dart';

part 'event_message.freezed.dart';

@freezed
class EventMessage with _$EventMessage {
  const factory EventMessage.sent(MessageWrapper messageWrapper) = _Sent;

  const factory EventMessage.received(MessageWrapper messageWrapper) = _Received;
}
