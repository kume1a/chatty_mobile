import 'dart:typed_data';

import 'package:common_utilities/common_utilities.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../schema/message/message_schema.dart';

class MultipartApiService {
  MultipartApiService(
    this._dio,
    this._baseUrl,
    this._eventBus,
  );

  final Dio _dio;
  final String? _baseUrl;
  final EventBus _eventBus;

  Future<MessageSchema> sendMessage({
    required int chatId,
    required String sendId,
    String? textMessage,
    Uint8List? imageFile,
  }) async {
    final FormData formData = FormData();

    formData.fields.add(MapEntry<String, String>('chatId', chatId.toString()));
    if (textMessage != null) {
      formData.fields.add(MapEntry<String, String>('textMessage', textMessage));
    }
    if (imageFile != null) {
      final MultipartFile multipartImageFile =
          MultipartFile.fromBytes(imageFile, filename: 'image.jpg');
      formData.files.add(MapEntry<String, MultipartFile>('imageFile', multipartImageFile));
    }

    final Response<Map<String, dynamic>> result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<MessageSchema>(
        Options(method: HttpMethod.POST)
            .compose(
              _dio.options,
              '/messages',
              data: formData,
              onSendProgress: (int count, int total) => _eventBus.fire(1),
            )
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
