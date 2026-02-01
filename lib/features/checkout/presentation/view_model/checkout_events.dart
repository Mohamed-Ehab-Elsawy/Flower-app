import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/presentation/models/payment_method_model.dart';

sealed class CheckoutEvents {}

sealed class CheckoutUiEvent {}

class GetUserAddressesEvents extends CheckoutEvents {
  final List<AddressesEntity>? addresses;

  GetUserAddressesEvents({this.addresses});
}

class SelectAddressEvents extends CheckoutEvents {
  final int selectedAddresses;

  SelectAddressEvents({required this.selectedAddresses});
}

class SelectedPaymentEvents extends CheckoutEvents {
  final PaymentMethodModel selectedPaymentMethod;

  SelectedPaymentEvents({required this.selectedPaymentMethod});
}

class CheckoutCashStateEvents extends CheckoutEvents {
  final CheckOutOrderRequest checkOutRequest;

  CheckoutCashStateEvents({required this.checkOutRequest});
}

class CheckoutCreditCardEvents extends CheckoutEvents {
  final CheckOutOrderRequest checkOutRequest;

  CheckoutCreditCardEvents({required this.checkOutRequest});
}

class ShowToast extends CheckoutUiEvent {
  final String message;
  final bool isError;

  ShowToast({required this.message, required this.isError});
}

class NavigateToHome extends CheckoutUiEvent {}

class NavigateToPayment extends CheckoutUiEvent {}

class NavigateToAddress extends CheckoutUiEvent {}
