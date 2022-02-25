import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/stores/current_user_info_store.dart';

@LazySingleton(as: CurrentUserInfoStore)
class CurrentUserInfoStoreImpl implements CurrentUserInfoStore {
  CurrentUserInfoStoreImpl(
    this._sharedPreferences,
  );

  final SharedPreferences _sharedPreferences;

  static const String _keyCurrentUserId = 'key_current_user_id';

  @override
  Future<void> writeCurrentUserId({
    required int userId,
  }) async =>
      _sharedPreferences.setInt(_keyCurrentUserId, userId);

  @override
  Future<int?> getCurrentUserId() async => _sharedPreferences.getInt(_keyCurrentUserId);

  @override
  Future<void> clear() async => _sharedPreferences.remove(_keyCurrentUserId);
}
