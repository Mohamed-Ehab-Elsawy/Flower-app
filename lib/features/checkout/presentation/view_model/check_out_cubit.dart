import 'dart:async';

import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entity/order_enyity.dart';
import 'package:flower_app/features/checkout/domain/entity/session_entity.dart';
import 'package:flower_app/features/checkout/domain/usecases/check_out.dart';
import 'package:flower_app/features/checkout/presentation/models/payment_method_model.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_events.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutStates> {
  final CheckOutUseCase _checkoutUseCase;

  CheckoutCubit(this._checkoutUseCase) : super(const CheckoutStates());
  final StreamController<CheckoutUiEvent> _checkoutUiEvent =
      StreamController.broadcast();

  Stream<CheckoutUiEvent> get checkoutUiEvent => _checkoutUiEvent.stream;

  void doEvent(CheckoutUiEvent event) {
    switch (event) {
      case ShowToast():
        _checkoutUiEvent.add(
          ShowToast(message: event.message, isError: event.isError),
        );
      case NavigateToHome():
        _checkoutUiEvent.add(NavigateToHome());
      case NavigateToPayment():
        _checkoutUiEvent.add(NavigateToPayment());
      case NavigateToAddress():
        _checkoutUiEvent.add(NavigateToAddress());
    }
  }

  void doIntent(CheckoutEvents event) {
    switch (event) {
      case GetUserAddressesEvents():
        _getUserAddresses();
      case SelectAddressEvents():
        _selectedAddress(event.selectedAddresses);
      case SelectedPaymentEvents():
        {
          _selectedPaymentMethod(event.selectedPaymentMethod);
        }
      case CheckoutCashStateEvents():
        _checkoutCash(event.checkOutRequest);
      case CheckoutCreditCardEvents():
        _checkoutCreditCard(event.checkOutRequest);
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

  void _selectedPaymentMethod(PaymentMethodModel selectedPaymentMethod) {
    emit(state.copyWith(selectedPaymentMethod: selectedPaymentMethod));
  }

  Future<void> _checkoutCash(CheckOutOrderRequest checkoutRequest) async {
    emit(
      state.copyWith(
        checkoutCashState: const BaseState<OrderEntity>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<OrderEntity> response = await _checkoutUseCase.checkoutCash(
      checkoutRequest,
    );
    switch (response) {
      case Success<OrderEntity>():
        {
          emit(
            state.copyWith(
              checkoutCashState: BaseState<OrderEntity>.loaded(response.data),
            ),
          );
        }
      case Failure<OrderEntity>():
        emit(
          state.copyWith(
            checkoutCashState: BaseState<OrderEntity>.error(
              response.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _checkoutCreditCard(CheckOutOrderRequest checkoutRequest) async {
    emit(
      state.copyWith(
        checkoutCreditCardState: const BaseState<SessionEntity>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<SessionEntity> response = await _checkoutUseCase.checkoutCreditCard(
      checkoutRequest,
    );
    switch (response) {
      case Success<SessionEntity>():
        {
          emit(
            state.copyWith(
              checkoutCreditCardState: BaseState<SessionEntity>.loaded(
                response.data,
              ),
            ),
          );
        }
      case Failure<SessionEntity>():
        emit(
          state.copyWith(
            checkoutCreditCardState: BaseState<SessionEntity>.error(
              response.errorMessage,
            ),
          ),
        );
    }
  }
}
