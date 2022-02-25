import 'dart:async';

import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/enums/message_type.dart';
import '../../../domain/models/message/message.dart';
import '../../../domain/stores/current_user_info_store.dart';
import '../../network/schema/message/message_schema.dart';
import '../enum_mappers/message_type_mapper.dart';

@lazySingleton
class MessageMapper extends BaseMapper<MessageSchema, Message> {
  MessageMapper(
    this._messageTypeMapper,
    this._currentUserInfoStore,
  );

  final MessageTypeMapper _messageTypeMapper;
  final CurrentUserInfoStore _currentUserInfoStore;

  @override
  Future<Message> mapToRight(MessageSchema l) async {
    final int? currentUserId = await _currentUserInfoStore.getCurrentUserId();

    final bool isOwn = currentUserId != null && currentUserId == l.userId;

    final DateTime? createdAt =
        l.createdAt != null ? DateTime.tryParse(l.createdAt!)?.toLocal() : null;
    final MessageType messageType = _messageTypeMapper.mapToRight(l.type);

    return Message(
      id: l.id ?? -1,
      type: messageType,
      textMessage: l.textMessage,
      imageUrl: l.imageUrl,
      videoUrl: l.videoUrl,
      gifUrl: l.gifUrl,
      createdAt: createdAt,
      isOwn: isOwn,
    );
  }
}
