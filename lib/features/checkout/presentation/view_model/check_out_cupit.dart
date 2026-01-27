import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/usecases/check_out.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_events.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutStates> {
  final CheckOutUseCase _checkoutUseCase;

  CheckoutCubit(this._checkoutUseCase) : super(const CheckoutStates());

  void doIntent(AddressEvents event) {
    switch (event) {
      case GetUserAddressesEvents():
        _getUserAddresses();
      case SelectAddressEvents():
        _selectedAddress(event.selectedAddresses);
    }
  }

  Future<void> _getUserAddresses() async {
    emit(
      state.copyWith(
        addressState: const BaseState<List<AddressesEntity>>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<List<AddressesEntity>> response = await _checkoutUseCase
        .getUserAddresses();
    switch (response) {
      case Success<List<AddressesEntity>>():
        {
          emit(
            state.copyWith(
              addressState: BaseState<List<AddressesEntity>>.loaded(
                response.data,
              ),
            ),
          );
        }
      case Failure<List<AddressesEntity>>():
        emit(
          state.copyWith(
            addressState: BaseState<List<AddressesEntity>>.error(
              response.errorMessage,
            ),
          ),
        );
    }
  }

  void _selectedAddress(int selectedAddress) {
    emit(state.copyWith(selectedAddress: selectedAddress));
  }
}
