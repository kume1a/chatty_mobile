import 'package:common_network_components/common_network_components.dart' as cnc;
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:synchronized/synchronized.dart';

import '../../../core/constants.dart';
import '../../../domain/stores/authentication_token_store.dart';
import '../../../main.dart';
import '../../../presentation/core/routes/screens_navigator.dart';

@lazySingleton
class SocketInstanceProvider {
  SocketInstanceProvider(
    this._authenticationTokenStore,
    this._screensNavigator,
  );

  final AuthenticationTokenStore _authenticationTokenStore;
  final ScreensNavigator _screensNavigator;

  final Lock _lock = Lock();

  Socket? _socket;

  Future<Socket?> get socketInstance async =>
      _lock.synchronized(() async => _socket ??= await _createSocket());

  Future<Socket?> _createSocket() async {
    try {
      final String? accessToken = await _authenticationTokenStore.readAccessToken();
      if (accessToken == null || cnc.JwtDecoder.isExpired(accessToken)) {
        _socket?.dispose();
        _socket = null;
        await _authenticationTokenStore.clear();
        _screensNavigator.toSignInPage();
        return null;
      }

      return io(
        Constants.wsUrl,
        OptionBuilder()
            .setTransports(<String>['websocket'])
            .setAuth(<String, String?>{
              'token': accessToken,
            })
            .disableAutoConnect()
            .build(),
      ).connect();
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  Future<void> dispose() async {
    _socket?.dispose();
    _socket = null;
  }
}
