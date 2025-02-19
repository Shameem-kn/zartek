abstract class UserPrefRepo {
  Future<void> saveUserData(String username, String uid, String imageUrl);
  Future<Map<String, String?>> getUserData();
  Future<void> deleteUserData();
}
