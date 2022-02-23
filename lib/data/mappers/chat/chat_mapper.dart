import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/chat/chat.dart';
import '../../network/schema/chat/chat_schema.dart';

@lazySingleton
class ChatMapper extends BaseMapper<ChatSchema, Chat> {
  @override
  Chat mapToRight(ChatSchema l) {
    return Chat(
      id: l.id ?? -1,
    );
  }
}
