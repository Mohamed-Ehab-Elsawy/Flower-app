class EndPoints {
  //>>>>>>>>>keys for api<<<<<<<<<<
  static const String quantity = 'quantity';

  static const String signUpEndpoint = "auth/signup";
  static const String forgetPassword = 'auth/forgotPassword';
  static const String verifyResetCode = 'auth/verifyResetCode';
  static const String resetPassword = 'auth/resetPassword';
  static const String login = "auth/signin";
  static const String bestSeller = 'best-seller';
  static const String home = "home";
  static const String products = "products/";
  static const String categories = "categories";
  static const String changePassword = "auth/change-password";
  static const String logout = "auth/logout";
  static const String cart = "cart";
  static const String deleteProductFromCard = "cart/{id}";
  static const String updateProductQuantity = "cart/{id}";
  static const String checkout = "orders/checkout";
}
