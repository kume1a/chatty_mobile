import 'package:injectable/injectable.dart';

import '../../domain/stores/authentication_token_store.dart';
import '../../domain/stores/safe_secure_storage.dart';

@LazySingleton(as: AuthenticationTokenStore)
class AuthKeyStoreImpl implements AuthenticationTokenStore {
  AuthKeyStoreImpl(
    this._safeSecureStorage,
  );

  final SafeSecureStorage _safeSecureStorage;

  static const String _keyAccessToken = 'key_access_token';

  @override
  Future<String?> readAccessToken() async => _safeSecureStorage.read(key: _keyAccessToken);

  @override
  Future<void> writeAccessToken({required String accessToken}) async =>
      _safeSecureStorage.write(key: _keyAccessToken, value: accessToken);

  @override
  Future<bool> hasAccessToken() async => _safeSecureStorage.containsKey(key: _keyAccessToken);

  @override
  Future<void> clear() async => _safeSecureStorage.delete(key: _keyAccessToken);
}
