class IAppText {
  static const String appName = "Flower App";

  //==============>Error Strings<==============
  static const String connectionTimeout = "Connection Timeout";
  static const String sendTimeout = "Send Timeout";
  static const String receiveTimeout = "Receive Timeout";
  static const String badCertificate = "Bad Certificate";
  static const String cancel = "Connection is Cancel";
  static const String connectionError = "Connection Error";
  static const String unknown = "Unknown Error";
  static const String error400 = 'Bad request. Please check your input.';
  static const String error401 = 'Unauthorized. Please try again.';
  static const String error403 =
      'Access forbidden. You don\'t have permission.';
  static const String error404 = 'Resource not found.';
  static const String error408 = 'Request timeout. Please try again.';
  static const String error429 =
      'Too many requests. Please wait and try again.';
  static const String error500 =
      'Internal server error. Please try again later.';
  static const String error502 =
      'Bad gateway. Server is temporarily unavailable.';
  static const String error503 = 'Service unavailable. Please try again later.';
  static const String error504 = 'Gateway timeout. Please try again.';
  static const String defaultError = 'Server error. Please try again.';


  //==============>Validation Strings<==============
  static const String enterUsername = "Please enter a username";
  static const String least3CharUsername =
      "Username must be at least 3 characters";
  static const String usernamePattern =
      'Username can only contain letters\nnumbers, and underscore';

  static const String enterFirstName = "Please enter your first name";
  static const String least2CharFirstName =
      'First name must be at least 2 characters';
  static const String firstNamePattern =
      'First name can only contain letters and spaces';

  static const String enterLastName = "Please enter your last name";
  static const String least2CharLastName =
      'Last name must be at least 2 characters';
  static const String lastNamePattern =
      'Last name can only contain letters and spaces';

  static const String enterEmail = "Please enter your email";
  static const String validEmail = "Please enter a valid email address";

  static const String enterPassword = "Please enter password";
  static const String passwordCriteria =
      "Password must be\nat least 8 characters\nand contain uppercase\nletter number,\nand special character";
  static const String passwordValidation =
      "Password must be\nat least 8 characters\nand contain uppercase\nletter number,\nand special character\n(@\$!%*?&)";
  static const String enterConfirmPassword = "Please confirm password";
  static const String confirmPasswordNotMatch = "Passwords do not match";

  static const String enterPhoneNumber = "Please enter your phone number";
  static const String validPhoneNumber =
      "Please enter a valid phone number with country code (e.g. +201012345678)";



}
