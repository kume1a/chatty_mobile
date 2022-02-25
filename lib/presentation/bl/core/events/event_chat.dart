import 'package:common_models/common_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/chat/chat.dart';

part 'event_chat.freezed.dart';

@freezed
class EventChat with _$EventChat {
  const factory EventChat.chatLoaded(Either<FetchFailure, Chat> chat) = _ChatLoaded;
}
