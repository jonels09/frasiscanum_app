import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String keyFirstName = 'user_firstName';
  static const String keyLastName = 'user_lastName';
  static const String keyLevel = 'user_level';
  static const String keyGender = 'user_gender';
  static const String keyUserImage = 'user_image';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required String level,
    required String gender,
  }) async {
    await _prefs.setString(keyFirstName, firstName);
    await _prefs.setString(keyLastName, lastName);
    await _prefs.setString(keyLevel, level);
    await _prefs.setString(keyGender, gender);
    await _prefs.setString(keyUserImage,
        gender == 'male' ? 'assets/images/boy.png' : 'assets/images/girl.png');
  }

  String? getFirstName() => _prefs.getString(keyFirstName);
  String? getLastName() => _prefs.getString(keyLastName);
  String? getLevel() => _prefs.getString(keyLevel);
  String? getGender() => _prefs.getString(keyGender);
  String? getUserImage() => _prefs.getString(keyUserImage);

  Future<void> clearUserData() async {
    await _prefs.remove(keyFirstName);
    await _prefs.remove(keyLastName);
    await _prefs.remove(keyLevel);
    await _prefs.remove(keyGender);
    await _prefs.remove(keyUserImage);
  }
}
