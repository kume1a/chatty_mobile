abstract class SafeSecureStorage {
  Future<bool> write({
    required String key,
    required String value,
  });

  Future<String?> read({
    required String key,
  });

  Future<bool> containsKey({
    required String key,
  });

  Future<bool> delete({required String key});
}
