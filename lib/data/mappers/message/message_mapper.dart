import 'dart:async';

import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/enums/message_type.dart';
import '../../../domain/models/common/image_meta.dart';
import '../../../domain/models/message/message.dart';
import '../../../domain/stores/current_user_info_store.dart';
import '../../network/schema/message/message_schema.dart';
import '../common/image_meta_mapper.dart';
import '../enum_mappers/message_type_mapper.dart';

@lazySingleton
class MessageMapper extends BaseMapper<MessageSchema, Message> {
  MessageMapper(
    this._messageTypeMapper,
    this._currentUserInfoStore,
    this._imageMetaMapper,
  );

  final MessageTypeMapper _messageTypeMapper;
  final CurrentUserInfoStore _currentUserInfoStore;
  final ImageMetaMapper _imageMetaMapper;

  @override
  Future<Message> mapToRight(MessageSchema l) async {
    final int? currentUserId = await _currentUserInfoStore.getCurrentUserId();

    final bool isOwn = currentUserId != null && currentUserId == l.userId;
    final DateTime? createdAt =
        l.createdAt != null ? DateTime.tryParse(l.createdAt!)?.toLocal() : null;
    final MessageType messageType = _messageTypeMapper.mapToRight(l.type);
    final ImageMeta? imageMeta =
        l.imageMeta != null ? _imageMetaMapper.mapToRight(l.imageMeta!) : null;

    return Message(
      id: l.id ?? -1,
      userId: l.userId ?? -1,
      chatId: l.chatId ?? -1,
      type: messageType,
      textMessage: l.textMessage,
      imageFilePath: l.imageFilePath,
      videoFilePath: l.videoFilePath,
      voiceFilePath: l.voiceFilePath,
      gifUrl: l.gifUrl,
      createdAt: createdAt,
      isOwn: isOwn,
      imageMeta: imageMeta,
    );
  }
}
