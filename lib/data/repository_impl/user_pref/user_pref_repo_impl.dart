import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/repo_impl/user_pref_repo.dart';

class UserPrefRepoImpl implements UserPrefRepo {
  final SharedPreferences _prefs;

  UserPrefRepoImpl(this._prefs);

  @override
  Future<void> saveUserData(
      String username, String uid, String imageUrl) async {
    await _prefs.setString('username', username);
    await _prefs.setString('uid', uid);
    await _prefs.setString('imageUrl', imageUrl);
  }

  @override
  Future<Map<String, String?>> getUserData() async {
    final username = _prefs.getString('username');
    final uid = _prefs.getString('uid');
    final imageUrl = _prefs.getString('imageUrl');
    return {
      'username': username,
      'uid': uid,
      'imageUrl': imageUrl,
    };
  }

  @override
  Future<void> deleteUserData() async {
    await _prefs.remove('username');
    await _prefs.remove('uid');
    await _prefs.remove('imageUrl');
  }
}
