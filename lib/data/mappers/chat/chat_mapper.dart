import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/chat/chat.dart';
import '../../../domain/models/message/message.dart';
import '../../../domain/models/user/user.dart';
import '../../network/schema/chat/chat_schema.dart';
import '../message/message_mapper.dart';
import '../user/user_mapper.dart';

@lazySingleton
class ChatMapper extends BaseMapper<ChatSchema, Chat> {
  ChatMapper(
    this._messageMapper,
    this._userMapper,
  );

  final MessageMapper _messageMapper;
  final UserMapper _userMapper;

  @override
  Future<Chat> mapToRight(ChatSchema l) async {
    final User? user = l.user != null ? _userMapper.mapToRight(l.user!) : null;
    final Message? lastMessage =
        l.lastMessage != null ? await _messageMapper.mapToRight(l.lastMessage!) : null;

    final DateTime? createdAt = l.createdAt != null ? DateTime.tryParse(l.createdAt!) : null;

    return Chat(
      id: l.id ?? -1,
      createdAt: createdAt,
      user: user,
      lastMessage: lastMessage,
    );
  }
}
