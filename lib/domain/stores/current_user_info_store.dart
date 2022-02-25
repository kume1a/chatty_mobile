abstract class CurrentUserInfoStore {
  Future<void> writeCurrentUserId({
    required int userId,
  });

  Future<int?> getCurrentUserId();

  Future<void> clear();
}
