abstract class AuthenticationTokenStore {
  Future<void> writeAccessToken({
    required String accessToken,
  });

  Future<String?> readAccessToken();

  Future<bool> hasAccessToken();

  Future<void> clear();
}
