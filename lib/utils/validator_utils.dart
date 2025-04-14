import 'package:validators2/validators2.dart';

class ValidatorUtils {
  static String? validatePassword(String? value, Function(String) onError) {
    if (value == null || value.isEmpty) {
      onError('Password cannot be empty!');
      return null;
    }
    if (!isLength(value, 6, 20)) {
      onError('Password must be between 6 and 20 characters!');
      return null;
    }
    if (!matches(value, r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$')) {
      onError('Password must contain at least one letter and one number!');
      return null;
    }
    return null;
  }

  static String? validateEmail(String? value, Function(String) onError) {
    if (value == null || value.isEmpty) {
      onError('Email cannot be empty!');
      return null;
    }
    if (!matches(value, r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')) {
      onError('Please enter a valid email address!');
      return null;
    }
    return null;
  }

  static String? validateName(String? value, Function(String) onError) {
    if (value == null || value.isEmpty) {
      onError('Name cannot be empty!');
      return null;
    }
    if (!matches(value, r'^[a-zA-Z\s]{2,30}$')) {
      onError(
          'Name must be 2-30 characters and contain only letters and spaces!');
      return null;
    }
    return null;
  }
}
