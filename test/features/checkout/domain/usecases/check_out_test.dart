import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entity/order_enyity.dart';
import 'package:flower_app/features/checkout/domain/entity/session_entity.dart';
import 'package:flower_app/features/checkout/domain/repo/check_out_repo.dart';
import 'package:flower_app/features/checkout/domain/usecases/check_out.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_out_test.mocks.dart';

@GenerateMocks([CheckOutRepo])
void main() {
  late MockCheckOutRepo mockCheckOutRepo;
  late CheckOutUseCase useCase;

  late SessionEntity sessionEntity;
  late OrderEntity orderEntity;
  late AddressesEntity addressesEntity;
  late List<AddressesEntity> addressesList;
  late CheckOutOrderRequest request;

  setUp(() {
    mockCheckOutRepo = MockCheckOutRepo();
    useCase = CheckOutUseCase(mockCheckOutRepo);

    sessionEntity = SessionEntity(
      id: "sess_123",
      object: "checkout.session",
      afterExpiration: "void",
      allowPromotionCodes: "true",
      amountTotal: 1500,
    );

    orderEntity = OrderEntity(
      createdAt: "2025-01-10",
      id: "order_456",
      updatedAt: "2025-01-10",
      V: 1,
      orderNumber: "ORD-00123",
      isPaid: true,
      isDelivered: false,
      orderItems: [OrderItems(price: 750, quantity: 2, id: "item1")],
      paymentType: "cash",
      state: "pending",
      totalPrice: 1500,
      user: "user_789",
    );

    addressesEntity = const AddressesEntity(
      id: "addr_1",
      street: "شارع الهرم",
      phone: "0123456789",
      city: "الجيزة",
      lat: "30.0444",
      long: "31.2357",
      username: "أحمد",
    );

    addressesList = [addressesEntity];

    request = CheckOutOrderRequest(
      shippingAddress: ShippingAddress(
        lat: "30.0444",
        long: "31.2357",
        street: "شارع الهرم",
        phone: "0123456789",
        city: "الجيزة",
      ),
    );

    provideDummy<Result<SessionEntity>>(Success(sessionEntity));
    provideDummy<Result<OrderEntity>>(Success(orderEntity));

    provideDummy<Result<List<AddressesEntity>>>(Success(addressesList));
  });

  group('CheckOutUseCase', () {
    test(
      'should call repo.checkoutCreditCard and return Success<SessionEntity>',
      () async {
        // arrange
        when(
          mockCheckOutRepo.checkoutCreditCard(any),
        ).thenAnswer((_) async => Success<SessionEntity>(sessionEntity));

        // act
        final result = await useCase.checkoutCreditCard(request);

        // assert
        verify(mockCheckOutRepo.checkoutCreditCard(request)).called(1);
        expect(result, isA<Success<SessionEntity>>());
        expect((result as Success<SessionEntity>).data, equals(sessionEntity));
      },
    );

    test(
      'should call repo.checkoutCash and return Success<OrderEntity>',
      () async {
        // arrange
        when(
          mockCheckOutRepo.checkoutCash(any),
        ).thenAnswer((_) async => Success<OrderEntity>(orderEntity));

        // act
        final result = await useCase.checkoutCash(request);

        // assert
        verify(mockCheckOutRepo.checkoutCash(request)).called(1);
        expect(result, isA<Success<OrderEntity>>());
        expect((result as Success<OrderEntity>).data, equals(orderEntity));
      },
    );

    test(
      'should call repo.getUserAddresses and return Success<List<AddressesEntity>>',
      () async {
        // arrange
        when(mockCheckOutRepo.getUserAddresses()).thenAnswer(
          (_) async => Success<List<AddressesEntity>>(addressesList),
        );

        // act
        final result = await useCase.getUserAddresses();

        // assert
        verify(mockCheckOutRepo.getUserAddresses()).called(1);
        expect(result, isA<Success<List<AddressesEntity>>>());
        expect(
          (result as Success<List<AddressesEntity>>).data,
          equals(addressesList),
        );
      },
    );
  });
}
