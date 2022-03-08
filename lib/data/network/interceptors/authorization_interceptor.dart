import 'dart:async';
import 'dart:io';

import 'package:common_network_components/common_network_components.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/stores/authentication_token_store.dart';
import '../../../presentation/core/navigation/screens_navigator.dart';

@injectable
class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor(
    this._authenticationTokenStore,
    this._screensNavigator,
  );

  final AuthenticationTokenStore _authenticationTokenStore;
  final ScreensNavigator _screensNavigator;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final String? accessToken = await _authenticationTokenStore.readAccessToken();
    if (accessToken != null) {
      if (JwtDecoder.isExpired(accessToken)) {
        await _clearExit();
        super.onRequest(options, handler);
        return;
      }
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.statusCode == 401) {
      _clearExit();
    } else {
      super.onResponse(response, handler);
    }
  }

  Future<void> _clearExit() async {
    await _authenticationTokenStore.clear();
    _screensNavigator.toSignInPage();
  }
}
