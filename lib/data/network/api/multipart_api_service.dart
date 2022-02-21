// ignore_for_file: unused_field, unused_element

import 'package:dio/dio.dart';

class MultipartApiService {
  MultipartApiService(
    this._dio,
    this._baseUrl,
  );

  final Dio _dio;
  final String? _baseUrl;

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
