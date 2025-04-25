import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:validators2/validators2.dart';

class ValidatorUtils {
  static String? validatePassword(String? value, Function(String) onError) {
    if (value == null || value.isEmpty) {
      onError(validatorPasswordEmpty);
      return null;
    }
    if (!isLength(value, 6, 20)) {
      onError(validatorPasswordLength);
      return null;
    }
    if (!matches(value, r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$')) {
      onError(validatorPasswordFormat);
      return null;
    }
    return null;
  }

  static String? validateEmail(String? value, Function(String) onError) {
    if (value == null || value.isEmpty) {
      onError(validatorEmailEmpty);
      return null;
    }

    if (!matches(value, r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')) {
      onError(validatorEmailFormat);
      return null;
    }
    return null;
  }

  static String? validateName(String? value, Function(String) onError) {
    if (value == null || value.isEmpty) {
      onError(validatorNameEmpty);
      return null;
    }
    if (!matches(value, r'^[a-zA-Z\s]{2,30}$')) {
      onError(validatorNameFormat);
      return null;
    }
    return null;
  }
}
