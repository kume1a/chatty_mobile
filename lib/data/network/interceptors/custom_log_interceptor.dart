import 'dart:convert';

import 'package:dio/dio.dart';

/// [LogInterceptor] is used to print logs during network requests.
/// It's better to add [LogInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.
class CustomLogInterceptor extends Interceptor {
  CustomLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logPrint = print,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file, for example:
  ///```dart
  ///  var file=File("./log.txt");
  ///  var sink=file.openWrite();
  ///  dio.interceptors.add(LogInterceptor(logPrint: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```
  void Function(Object object) logPrint;

  static JsonDecoder decoder = const JsonDecoder();
  static JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final StringBuffer output = StringBuffer();
    output.writeln('*** Request ***');
    output.writeln(_keyValue('uri', options.uri));

    if (request) {
      output.writeln(_keyValue('method', options.method));
      output.writeln(_keyValue('responseType', options.responseType.toString()));
      output.writeln(_keyValue('followRedirects', options.followRedirects));
      output.writeln(_keyValue('connectTimeout', options.connectTimeout));
      output.writeln(_keyValue('sendTimeout', options.sendTimeout));
      output.writeln(_keyValue('receiveTimeout', options.receiveTimeout));
      output.writeln(_keyValue('receiveDataWhenStatusError', options.receiveDataWhenStatusError));
      output.writeln(_keyValue('extra', options.extra));
    }
    if (requestHeader) {
      output.writeln('headers:');
      options.headers.forEach((String key, dynamic v) => output.writeln(_keyValue(' $key', v)));
    }
    if (requestBody) {
      output.writeln('data:');
      output.writeln(options.data.toString());
    }
    output.writeln();

    logPrint(output.toString());

    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final StringBuffer output = StringBuffer();
    output.writeln('*** Response ***');
    output.writeln(_getResponseString(response));

    logPrint(output.toString());
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (error) {
      final StringBuffer output = StringBuffer();

      output.writeln('*** DioError ***:');
      output.writeln('uri: ${err.requestOptions.uri}');
      output.writeln('$err');
      if (err.response != null) {
        output.writeln(_getResponseString(err.response!));
      }
      output.writeln();

      logPrint(output.toString());
    }

    handler.next(err);
  }

  String _getResponseString(Response<dynamic> response) {
    final StringBuffer output = StringBuffer();
    output.writeln(_keyValue('uri', response.requestOptions.uri));
    if (responseHeader) {
      output.writeln(_keyValue('statusCode', response.statusCode));
      if (response.isRedirect == true) {
        output.writeln(_keyValue('redirect', response.realUri));
      }

      output.writeln('headers:');
      response.headers
          // ignore: avoid_dynamic_calls
          .forEach((String key, dynamic v) => output.writeln(_keyValue(' $key', v.join('\r\n\t'))));
    }
    if (responseBody) {
      output.writeln('Response Text:');
      String? prettyJson;
      try {
        final dynamic object = decoder.convert(response.toString());
        prettyJson = encoder.convert(object);
      } catch (e) {
        /* ignored */
      }

      output.writeln(prettyJson ?? response.toString());
    }
    output.writeln();

    return output.toString();
  }

  String _keyValue(String key, Object? v) => '$key: $v';
}
