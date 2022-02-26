import 'package:freezed_annotation/freezed_annotation.dart';

import '../message/message.dart';
import '../user/user.dart';

part 'chat.freezed.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required int id,
    required DateTime? createdAt,
    required User? user,
    required Message? lastMessage,
  }) = _Chat;
}
