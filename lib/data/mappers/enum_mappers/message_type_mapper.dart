import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/enums/message_type.dart';

@lazySingleton
class MessageTypeMapper extends BaseMapper<String?, MessageType> {
  @override
  MessageType mapToRight(String? l) {
    switch (l) {
      case 'TEXT':
        return MessageType.text;
      case 'VIDEO':
        return MessageType.video;
      case 'IMAGE':
        return MessageType.image;
      case 'FILE':
        return MessageType.file;
      case 'VOICE':
        return MessageType.voice;
      case 'GIF':
        return MessageType.gif;
      default:
        return MessageType.unknown;
    }
  }
}
