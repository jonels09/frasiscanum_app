import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  final SharedPreferences _prefs;

  AuthProvider(this._prefs) {
    _loadUser();
  }

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<void> _loadUser() async {
    final userJson = _prefs.getString('user');
    if (userJson != null) {
      _currentUser = User.fromJson(Map<String, dynamic>.from(
        Map.from(userJson as Map),
      ));
      notifyListeners();
    }
  }

  Future<void> login(User user) async {
    _currentUser = user;
    await _prefs.setString('user', user.toJson().toString());
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    await _prefs.remove('user');
    notifyListeners();
  }
}
