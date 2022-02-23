import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/message/message.dart';
import '../../network/schema/message/message_schema.dart';

@lazySingleton
class MessageMapper extends BaseMapper<MessageSchema, Message> {
  @override
  Message mapToRight(MessageSchema l) {
    final DateTime? createdAt =
        l.createdAt != null ? DateTime.tryParse(l.createdAt!)?.toLocal() : null;

    return Message(
      id: l.id ?? -1,
      type: l.type,
      textMessage: l.textMessage,
      imageUrl: l.imageUrl,
      videoUrl: l.videoUrl,
      gifUrl: l.gifUrl,
      createdAt: createdAt,
    );
  }
}
