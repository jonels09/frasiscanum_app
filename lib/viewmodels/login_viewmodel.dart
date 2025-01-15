/*import 'package:flutter/foundation.dart';
import '../models/user.dart';

class LoginViewModel extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _level = 'Mpijerijery';
  bool _isMale = true;
  bool _isValid = false;

  // Getters
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get level => _level;
  bool get isMale => _isMale;
  bool get isValid => _isValid;

  // Setters with validation
  void setFirstName(String value) {
    _firstName = value;
    _validateForm();
  }

  void setLastName(String value) {
    _lastName = value;
    _validateForm();
  }

  void setLevel(String value) {
    _level = value;
    _validateForm();
  }

  void setGender(bool value) {
    _isMale = value;
    notifyListeners();
  }

  void _validateForm() {
    _isValid =
        _firstName.isNotEmpty && _lastName.isNotEmpty && _level.isNotEmpty;
    notifyListeners();
  }

  User buildUser() {
    return User(
      firstName: _firstName,
      lastName: _lastName,
      level: _level,
      gender: _isMale ? 'male' : 'female',
    );
  }
}
*/

import 'package:flutter/foundation.dart';
import '../models/user.dart';

class LoginViewModel extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _level = 'Mpijerijery';
  bool _isMale = true;
  bool _isValid = false;

  // Getters
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get level => _level;
  bool get isMale => _isMale;
  bool get isValid => _isValid;

  // Setters with validation
  void setFirstName(String value) {
    _firstName = value.trim();
    _validateForm();
  }

  void setLastName(String value) {
    _lastName = value.trim();
    _validateForm();
  }

  void setLevel(String value) {
    _level = value;
    _validateForm();
  }

  void setGender(bool value) {
    _isMale = value;
    notifyListeners();
  }

  void _validateForm() {
    _isValid =
        _firstName.isNotEmpty && _lastName.isNotEmpty && _level.isNotEmpty;
    notifyListeners();
  }

  User buildUser() {
    return User(
      firstName: _firstName,
      lastName: _lastName,
      level: _level,
      gender: _isMale ? 'male' : 'female',
    );
  }
}
