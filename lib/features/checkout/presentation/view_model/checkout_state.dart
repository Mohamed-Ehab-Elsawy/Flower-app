import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entity/order_enyity.dart';
import 'package:flower_app/features/checkout/domain/entity/session_entity.dart';
import 'package:flower_app/features/checkout/presentation/models/payment_method_model.dart';

class CheckoutStates extends Equatable {
  final BaseState<List<AddressesEntity>>? addressState;
  final BaseState<OrderEntity>? checkoutCashState;
  final BaseState<SessionEntity>? checkoutCreditCardState;
  final int? selectedAddress;
  final PaymentMethodModel? selectedPaymentMethod;

  const CheckoutStates({
    this.addressState,
    this.selectedAddress,
    this.selectedPaymentMethod,
    this.checkoutCashState,
    this.checkoutCreditCardState,
  });

  CheckoutStates copyWith({
    BaseState<List<AddressesEntity>>? addressState,
    BaseState<OrderEntity>? checkoutCashState,
    BaseState<SessionEntity>? checkoutCreditCardState,
    int? selectedAddress,
    PaymentMethodModel? selectedPaymentMethod,
  }) {
    return CheckoutStates(
      addressState: addressState ?? this.addressState,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      checkoutCashState: checkoutCashState ?? this.checkoutCashState,
      checkoutCreditCardState:
          checkoutCreditCardState ?? this.checkoutCreditCardState,
    );
  }

  @override
  List<Object?> get props => [
    addressState,
    selectedAddress,
    selectedPaymentMethod,
    checkoutCashState,
    checkoutCreditCardState,
  ];
}
