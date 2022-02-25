import 'dart:async';

import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/message/message.dart';
import '../../network/schema/message/message_schema.dart';
import '../../network/schema/message/messages_page_schema.dart';
import 'message_mapper.dart';

@lazySingleton
class MessagesPageMapper extends BaseMapper<MessagesPageSchema, DataPage<Message>> {
  MessagesPageMapper(
    this._messageMapper,
  );

  final MessageMapper _messageMapper;

  @override
  Future<DataPage<Message>> mapToRight(MessagesPageSchema l) async {
    final List<Message> messages = l.data != null
        ? await Future.wait(l.data!.map((MessageSchema e) => _messageMapper.mapToRight(e)))
        : List<Message>.empty();

    return DataPage<Message>(
      items: messages,
      count: l.count ?? 0,
    );
  }
}
