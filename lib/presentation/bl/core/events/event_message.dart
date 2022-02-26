import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/message/message.dart';

part 'event_message.freezed.dart';

@freezed
class EventMessage with _$EventMessage {
  const factory EventMessage.sent(Message message) = _Sent;

  const factory EventMessage.received(Message message) = _Received;
}
