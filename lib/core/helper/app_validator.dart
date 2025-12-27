import 'package:easy_localization/easy_localization.dart';
class AppValidator {
  static const _userNamePattern = r'^[\p{L}\p{N}_]+$';
  static const _namePattern = r'^[\p{L}\s]+$';
  static const _emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const _phonePattern = r'^\+[1-9]\d{7,14}$';

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.enterUsername'.tr();
    } else if (value.trim().length < 3) {
      return 'validation.least3CharUsername'.tr();
    } else if (!RegExp(
      _userNamePattern,
      unicode: true,
    ).hasMatch(value.trim())) {
      return 'validation.usernamePattern'.tr();
    }
    return null;
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.enterFirstName'.tr();
    } else if (value.trim().length < 2) {
      return 'validation.least2CharFirstName'.tr();
    } else if (!RegExp(_namePattern, unicode: true).hasMatch(value.trim())) {
      return 'validation.firstNamePattern'.tr();
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.enterLastName'.tr();
    } else if (value.trim().length < 2) {
      return 'validation.least2CharLastName'.tr();
    } else if (!RegExp(_namePattern, unicode: true).hasMatch(value.trim())) {
      return 'validation.lastNamePattern'.tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.enterEmail'.tr();
    } else if (!RegExp(_emailPattern).hasMatch(value)) {
      return 'validation.validEmail'.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final trimmed = value?.trim();

    if (trimmed == null || trimmed.isEmpty) {
      return 'validation.enterPassword'.tr();
    }

    if (trimmed.length < 8) {
      return 'validation.passwordCriteria'.tr();
    }

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(trimmed);
    final hasDigit = RegExp(r'\d').hasMatch(trimmed);
    final hasSpecial = RegExp(r'[@$!%*?&]').hasMatch(trimmed);

    if (hasUppercase && hasDigit && hasSpecial) {
      return null;
    }

    return 'validation.passwordValidation'.tr();
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'validation.enterConfirmPassword'.tr();
    } else if (value != originalPassword) {
      return 'validation.confirmPasswordNotMatch'.tr();
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.enterPhoneNumber'.tr();
    }

    final cleaned = value.replaceAll(RegExp(r'\s+'), '');

    if (!RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(cleaned)) {
      return 'validation.validPhoneNumber'.tr();
    }

    return null;
  }
}
