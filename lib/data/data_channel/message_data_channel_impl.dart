import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../domain/data_channels/message_data_channel.dart';
import '../../domain/models/message/message.dart';
import '../../main.dart';
import '../mappers/message/message_mapper.dart';
import '../network/schema/message/message_schema.dart';
import '../network/ws/socket_instance_provider.dart';

@Injectable(as: MessageDataChannel)
class MessageDataChannelImpl implements MessageDataChannel {
  MessageDataChannelImpl(
    this._socketInstanceProvider,
    this._messageMapper,
  );

  final SocketInstanceProvider _socketInstanceProvider;
  final MessageMapper _messageMapper;

  static const String _event = 'messageSentToClient';

  final StreamController<Message> _streamController = StreamController<Message>();

  @override
  Stream<Message> get events => _streamController.stream;

  @override
  Future<void> stopListening() async {
    final Socket? socket = await _socketInstanceProvider.socketInstance;
    socket?.off(_event, _handleMessageEvent);
  }

  @override
  Future<void> startListening() async {
    final Socket? socket = await _socketInstanceProvider.socketInstance;
    socket?.on(_event, _handleMessageEvent);
  }

  Future<void> _handleMessageEvent(dynamic data) async {
    try {
      logger.d(data);
      final MessageSchema messageSchema = MessageSchema.fromJson(data as Map<String, dynamic>);
      final Message message = await _messageMapper.mapToRight(messageSchema);

      _streamController.sink.add(message);
    } catch (e) {
      logger.e(e);
    }
  }
}
