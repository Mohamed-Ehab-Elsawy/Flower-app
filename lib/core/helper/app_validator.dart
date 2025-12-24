import 'package:flower_app/core/constants/text_strings.dart';

class AppValidator {
  static const _userNamePattern = r'^[\p{L}\p{N}_]+$';
  static const _namePattern = r'^[\p{L}\s]+$';
  static const _emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const _phonePattern = r'^\+[1-9]\d{7,14}$';

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return IAppText.enterUsername;
    } else if (value.trim().length < 3) {
      return IAppText.least3CharUsername;
    } else if (!RegExp(
      _userNamePattern,
      unicode: true,
    ).hasMatch(value.trim())) {
      return IAppText.usernamePattern;
    }
    return null;
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return IAppText.enterFirstName;
    } else if (value.trim().length < 2) {
      return IAppText.least2CharFirstName;
    } else if (!RegExp(_namePattern, unicode: true).hasMatch(value.trim())) {
      return IAppText.firstNamePattern;
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return IAppText.enterLastName;
    } else if (value.trim().length < 2) {
      return IAppText.least2CharLastName;
    } else if (!RegExp(_namePattern, unicode: true).hasMatch(value.trim())) {
      return IAppText.lastNamePattern;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return IAppText.enterEmail;
    } else if (!RegExp(_emailPattern).hasMatch(value)) {
      return IAppText.validEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final trimmed = value?.trim();

    if (trimmed == null || trimmed.isEmpty) {
      return IAppText.enterPassword;
    }

    if (trimmed.length < 8) {
      return IAppText.passwordCriteria;
    }

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(trimmed);
    final hasDigit = RegExp(r'\d').hasMatch(trimmed);
    final hasSpecial = RegExp(r'[@$!%*?&]').hasMatch(trimmed);

    if (hasUppercase && hasDigit && hasSpecial) {
      return null;
    }

    return IAppText.passwordValidation;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return IAppText.enterConfirmPassword;
    } else if (value != originalPassword) {
      return IAppText.confirmPasswordNotMatch;
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return IAppText.enterPhoneNumber;
    }

    final cleaned = value.replaceAll(RegExp(r'\s+'), '');

    if (!RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(cleaned)) {
      return IAppText.validPhoneNumber;
    }

    return null;
  }
}
