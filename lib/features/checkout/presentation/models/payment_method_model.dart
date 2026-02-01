enum PaymentMethodModel {
  cash("Cash"),
  card("Credit");

  final String method;

  const PaymentMethodModel(this.method);

  String get displayMethod {
    switch (this) {
      case PaymentMethodModel.cash:
        return "Cash on delivery";
      case PaymentMethodModel.card:
        return "Credit card";
    }
  }
}
