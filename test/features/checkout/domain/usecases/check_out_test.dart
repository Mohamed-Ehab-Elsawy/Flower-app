import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entity/order_enyity.dart';
import 'package:flower_app/features/checkout/domain/entity/session_entity.dart';
import 'package:flower_app/features/checkout/domain/repo/check_out_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_out_test.mocks.dart';

@GenerateMocks([CheckOutRepo])
void main() {
  late MockCheckOutRepo mockCheckOutRepo;
  late SessionEntity sessionEntity;
  late AddressesEntity addressesEntity;
  late List<AddressesEntity> addressesEntityList;
  late OrderEntity orderEntity;
  late CheckOutOrderRequest checkOutOrderRequest;
  setUp(() {
    mockCheckOutRepo = MockCheckOutRepo();
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
    provideDummy<Result<SessionEntity>>(Success<SessionEntity>(sessionEntity));
    provideDummy<Result<OrderEntity>>(Success<OrderEntity>(orderEntity));
    provideDummy<Result<List<AddressesEntity>>>(
      Success<List<AddressesEntity>>(addressesEntityList),
    );
  });
  test('test calling  checkOutCreditCard in use_cases ', () async {
    when(
      mockCheckOutRepo.checkoutCreditCard(checkOutOrderRequest),
    ).thenAnswer((_) async => Success<SessionEntity>(sessionEntity));
    await mockCheckOutRepo.checkoutCreditCard(checkOutOrderRequest);
    verify(mockCheckOutRepo.checkoutCreditCard(checkOutOrderRequest)).called(1);
  });
  test('test calling  checkoutCash in use_cases ', () async {
    when(
      mockCheckOutRepo.checkoutCash(checkOutOrderRequest),
    ).thenAnswer((_) async => Success<OrderEntity>(orderEntity));
    await mockCheckOutRepo.checkoutCash(checkOutOrderRequest);
    verify(mockCheckOutRepo.checkoutCash(checkOutOrderRequest)).called(1);
  });
  test('test calling  getUserAddresses in use_cases ', () async {
    when(mockCheckOutRepo.getUserAddresses()).thenAnswer(
      (_) async => Success<List<AddressesEntity>>(addressesEntityList),
    );
    await mockCheckOutRepo.getUserAddresses();
    verify(mockCheckOutRepo.getUserAddresses()).called(1);
  });
}
