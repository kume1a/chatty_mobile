import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../main.dart';
import '../../data/network/interceptors/authorization_interceptor.dart';
import '../../data/network/interceptors/custom_log_interceptor.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(
    AuthorizationInterceptor authorizationInterceptor,
  ) {
    final Dio dio = Dio(
      BaseOptions(
        contentType: 'application/json',
        connectTimeout: 20000,
        sendTimeout: 20000,
      ),
    );

    dio.interceptors.add(authorizationInterceptor);
    dio.interceptors.add(CustomLogInterceptor(responseBody: true, logPrint: logger.d));

    return dio;
  }
}
