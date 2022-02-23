import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../schema/body/send_message_body.dart';
import '../schema/message/message_schema.dart';

class MultipartApiService {
  MultipartApiService(
    this._dio,
    this._baseUrl,
  );

  final Dio _dio;
  final String? _baseUrl;

  Future<MessageSchema> sendMessage(SendMessageBody body) async {
    final Response<Map<String, dynamic>> result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<MessageSchema>(
        Options(method: HttpMethod.POST)
            .compose(_dio.options, '/messages', data: body.toJson())
            .copyWith(baseUrl: _baseUrl ?? _dio.options.baseUrl),
      ),
    );

    return MessageSchema.fromJson(result.data!);
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
