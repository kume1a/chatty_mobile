import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/stores/safe_secure_storage.dart';
import '../../main.dart';

@LazySingleton(as: SafeSecureStorage)
class SafeSecureStorageImpl implements SafeSecureStorage {
  SafeSecureStorageImpl(
    this._secureStorage,
  );

  final FlutterSecureStorage _secureStorage;

  @override
  Future<bool> containsKey({required String key}) async {
    try {
      final String? value = await _secureStorage.read(key: key);
      return value != null;
    } catch (e) {
      logger.e(e);
    }
    return false;
  }

  @override
  Future<bool> delete({required String key}) async {
    try {
      await _secureStorage.delete(key: key);
      return true;
    } catch (e) {
      logger.e(e);
    }
    return false;
  }

  @override
  Future<String?> read({required String key}) async {
    try {
      return _secureStorage.read(key: key);
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  @override
  Future<bool> write({required String key, required String value}) async {
    try {
      await _secureStorage.write(key: key, value: value);
      return true;
    } catch (e) {
      logger.e(e);
    }
    return false;
  }
}
