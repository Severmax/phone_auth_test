abstract class AuthRepository {
  Future<bool> register(String phone, String password);
  Future<bool> login(String phone, String password);
  Future<bool> isLoggedIn();
  Future<void> logout();
  Future<Map<String, String>?> getCurrentUser();
}