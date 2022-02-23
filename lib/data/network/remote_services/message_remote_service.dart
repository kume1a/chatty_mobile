import 'package:common_models/common_models.dart';
import 'package:common_network_components/common_network_components.dart';
import 'package:injectable/injectable.dart';

import '../api/api_service.dart';
import '../api/multipart_api_service.dart';
import '../schema/body/send_message_body.dart';
import '../schema/message/message_schema.dart';
import '../schema/message/messages_page_schema.dart';

@lazySingleton
class MessageRemoteService extends BaseService {
  MessageRemoteService(
    this._apiService,
    this._multipartApiService,
  );

  final ApiService _apiService;
  final MultipartApiService _multipartApiService;

  Future<Either<SimpleActionFailure, MessageSchema>> sendMessage({
    required int chatId,
    String? textMessage,
  }) async =>
      safeSimpleCall(() {
        final SendMessageBody body = SendMessageBody(
          chatId: chatId,
          textMessage: textMessage,
        );

        return _multipartApiService.sendMessage(body);
      });

  Future<Either<FetchFailure, MessagesPageSchema>> getMessages({
    required int chatId,
    required int? lastId,
    required int takeCount,
  }) async =>
      safeFetch(() => _apiService.getMessages(chatId, lastId, takeCount));
}
