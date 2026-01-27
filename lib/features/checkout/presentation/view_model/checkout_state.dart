import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';

class CheckoutStates extends Equatable {
  final BaseState<List<AddressesEntity>>? addressState;
  final int? selectedAddress;

  const CheckoutStates({this.addressState, this.selectedAddress});

  CheckoutStates copyWith({
    BaseState<List<AddressesEntity>>? addressState,
    int? selectedAddress,
  }) {
    return CheckoutStates(
      addressState: addressState ?? this.addressState,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }

  @override
  List<Object?> get props => [addressState, selectedAddress];
}
