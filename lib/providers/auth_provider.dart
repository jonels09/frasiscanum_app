/*import 'package:flutter/foundation.dart';
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
*/

import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/storage_service.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  final StorageService _storageService;

  AuthProvider(this._storageService) {
    _loadUser();
  }

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  void _loadUser() {
    final firstName = _storageService.getFirstName();
    final lastName = _storageService.getLastName();
    final level = _storageService.getLevel();
    final gender = _storageService.getGender();

    if (firstName != null &&
        lastName != null &&
        level != null &&
        gender != null) {
      _currentUser = User(
        firstName: firstName,
        lastName: lastName,
        level: level,
        gender: gender,
      );
      notifyListeners();
    }
  }

  Future<void> login(User user) async {
    await _storageService.saveUserData(
      firstName: user.firstName,
      lastName: user.lastName,
      level: user.level,
      gender: user.gender,
    );
    _currentUser = user;
    notifyListeners();
  }

  Future<void> logout() async {
    await _storageService.clearUserData();
    _currentUser = null;
    notifyListeners();
  }
}
