import 'package:freezed_annotation/freezed_annotation.dart';

import '../../enums/message_type.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required int id,
    required MessageType type,
    required String? textMessage,
    required String? imageUrl,
    required String? videoUrl,
    required String? gifUrl,
    required DateTime? createdAt,
    required bool isOwn,
  }) = _Message;
}
