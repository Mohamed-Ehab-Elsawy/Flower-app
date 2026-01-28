import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entity/order_enyity.dart';
import 'package:flower_app/features/checkout/domain/entity/session_entity.dart';
import 'package:flower_app/features/checkout/domain/usecases/check_out.dart';
import 'package:flower_app/features/checkout/presentation/models/payment_method_model.dart';
import 'package:flower_app/features/checkout/presentation/view_model/check_out_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_events.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_out_cubit_test.mocks.dart';

@GenerateMocks([CheckOutUseCase])
void main() {
  late SessionEntity sessionEntity;
  late AddressesEntity addressesEntity;
  late List<AddressesEntity> addressesEntityList;
  late OrderEntity orderEntity;
  late CheckOutOrderRequest checkOutOrderRequest;
  late PaymentMethodModel paymentMethodModel;
  late MockCheckOutUseCase mockCheckOutUseCase;
  setUp(() {
    mockCheckOutUseCase = MockCheckOutUseCase();
    sessionEntity = SessionEntity(
      id: "id",
      object: "object",
      afterExpiration: "afterExpiration",
      allowPromotionCodes: "allowPromotionCodes",
      amountTotal: 0,
    );
    orderEntity = OrderEntity(
      createdAt: "createdAt",
      id: "id",
      updatedAt: "updatedAt",
      V: 0,
      orderNumber: "orderNumber",
      isPaid: false,
      isDelivered: false,
      orderItems: [OrderItems(price: 0, quantity: 0, id: "id")],
      paymentType: "paymentType",
      state: "state",
      totalPrice: 0,
      user: "user",
    );
    addressesEntity = const AddressesEntity(
      street: "street",
      phone: "phone",
      city: "city",
      lat: "lat",
      long: "long",
      username: "username",
      id: "id",
    );
    addressesEntityList = [addressesEntity, addressesEntity];
    checkOutOrderRequest = CheckOutOrderRequest(
      shippingAddress: ShippingAddress(lat: "lk"),
    );
    paymentMethodModel = PaymentMethodModel.card;
    provideDummy<Result<SessionEntity>>(Success<SessionEntity>(sessionEntity));
    provideDummy<Result<OrderEntity>>(Success<OrderEntity>(orderEntity));
    provideDummy<Result<List<AddressesEntity>>>(
      Success<List<AddressesEntity>>(addressesEntityList),
    );
  });
  blocTest<CheckoutCubit, CheckoutStates>(
    ' emits [loading, success] when _checkoutCreditCard returns Success',
    build: () {
      when(
        mockCheckOutUseCase.checkoutCreditCard(checkOutOrderRequest),
      ).thenAnswer((_) async => Success<SessionEntity>(sessionEntity));
      return CheckoutCubit(mockCheckOutUseCase);
    },
    act: (bloc) => bloc.doIntent(
      CheckoutCreditCardEvents(checkOutRequest: checkOutOrderRequest),
    ),
    expect: () {
      var state = const CheckoutStates(
        checkoutCreditCardState: BaseState<SessionEntity>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          checkoutCreditCardState: const BaseState<SessionEntity>(
            requestState: RequestState.loading,
          ),
        ),

        state.copyWith(
          checkoutCreditCardState: BaseState<SessionEntity>(
            data: sessionEntity,
            requestState: RequestState.loaded,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(
        mockCheckOutUseCase.checkoutCreditCard(checkOutOrderRequest),
      ).called(1);
    },
  );

  blocTest<CheckoutCubit, CheckoutStates>(
    ' emits [loading, success] when _checkoutCash returns Success',
    build: () {
      when(
        mockCheckOutUseCase.checkoutCash(checkOutOrderRequest),
      ).thenAnswer((_) async => Success<OrderEntity>(orderEntity));
      return CheckoutCubit(mockCheckOutUseCase);
    },
    act: (bloc) => bloc.doIntent(
      CheckoutCashStateEvents(checkOutRequest: checkOutOrderRequest),
    ),
    expect: () {
      var state = const CheckoutStates(
        checkoutCashState: BaseState<OrderEntity>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          checkoutCashState: const BaseState<OrderEntity>(
            requestState: RequestState.loading,
          ),
        ),

        state.copyWith(
          checkoutCashState: BaseState<OrderEntity>(
            data: orderEntity,
            requestState: RequestState.loaded,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockCheckOutUseCase.checkoutCash(checkOutOrderRequest)).called(1);
    },
  );

  blocTest<CheckoutCubit, CheckoutStates>(
    ' emits [loading, success] when _getUserAddresses returns Success',
    build: () {
      when(mockCheckOutUseCase.getUserAddresses()).thenAnswer(
        (_) async => Success<List<AddressesEntity>>(addressesEntityList),
      );
      return CheckoutCubit(mockCheckOutUseCase);
    },
    act: (bloc) => bloc.doIntent(GetUserAddressesEvents()),
    expect: () {
      var state = const CheckoutStates(
        addressState: BaseState<List<AddressesEntity>>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          addressState: const BaseState<List<AddressesEntity>>(
            requestState: RequestState.loading,
          ),
        ),

        state.copyWith(
          addressState: BaseState<List<AddressesEntity>>(
            data: addressesEntityList,
            requestState: RequestState.loaded,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockCheckOutUseCase.getUserAddresses()).called(1);
    },
  );
  blocTest<CheckoutCubit, CheckoutStates>(
    ' _selectedAddress emits selectedAddress'
    ' when doIntent is called',
    build: () {
      return CheckoutCubit(mockCheckOutUseCase);
    },
    act: (bloc) => bloc.doIntent(SelectAddressEvents(selectedAddresses: 1)),
    expect: () {
      var state = const CheckoutStates(selectedAddress: 1);
      return [state.copyWith(selectedAddress: 1)];
    },
  );

  blocTest<CheckoutCubit, CheckoutStates>(
    '_selectedPaymentMethod emits selectedPaymentMethod when doIntent is called',
    build: () => CheckoutCubit(mockCheckOutUseCase),
    act: (bloc) => bloc.doIntent(
      SelectedPaymentEvents(selectedPaymentMethod: paymentMethodModel),
    ),
    expect: () => [CheckoutStates(selectedPaymentMethod: paymentMethodModel)],
  );
}
