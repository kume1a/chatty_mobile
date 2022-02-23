import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/chat/chat.dart';
import '../../network/schema/chat/chat_schema.dart';
import '../../network/schema/chat/chats_page_schema.dart';
import 'chat_mapper.dart';

@lazySingleton
class ChatsPageMapper extends BaseMapper<ChatsPageSchema, DataPage<Chat>> {
  ChatsPageMapper(
    this._chatMapper,
  );

  final ChatMapper _chatMapper;

  @override
  DataPage<Chat> mapToRight(ChatsPageSchema l) {
    final List<Chat> chats =
        l.data?.map((ChatSchema e) => _chatMapper.mapToRight(e)).toList() ?? List<Chat>.empty();

    return DataPage<Chat>(
      items: chats,
      count: l.count ?? 0,
    );
  }
}
