import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/data_sources/check_out_data_source.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/address_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';
import 'package:flower_app/features/checkout/data/repo/check_out_repo_impl.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entity/order_enyity.dart';
import 'package:flower_app/features/checkout/domain/entity/session_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_out_repo_impl_test.mocks.dart';

@GenerateMocks([CheckOutDataSource])
void main() {
  late CheckOutRepoImpl repo;
  late MockCheckOutDataSource dataSource;
  late SessionDto sessionDto;
  late AddressesDto addressesDto;
  late List<AddressesDto> addressesDtoList;
  late OrderDto orderDto;
  late CheckOutOrderRequest checkOutOrderRequest;
  late String exception;
  setUpAll(() {
    dataSource = MockCheckOutDataSource();
    repo = CheckOutRepoImpl(dataSource);
    sessionDto = SessionDto(
      id: "id",
      object: "object",
      afterExpiration: "afterExpiration",
      allowPromotionCodes: "allowPromotionCodes",
      amountTotal: 0,
    );
    orderDto = OrderDto(
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
    addressesDto = AddressesDto(
      street: "street",
      phone: "phone",
      city: "city",
      lat: "lat",
      long: "long",
      username: "username",
      id: "id",
    );
    addressesDtoList = [addressesDto, addressesDto];
    exception = "error";
    checkOutOrderRequest = CheckOutOrderRequest(
      shippingAddress: ShippingAddress(lat: "lk"),
    );
    provideDummy<Result<SessionDto>>(Success<SessionDto>(sessionDto));
    provideDummy<Result<OrderDto>>(Success<OrderDto>(orderDto));
    provideDummy<Result<List<AddressesDto>>>(
      Success<List<AddressesDto>>(addressesDtoList),
    );
  });
  group("test checkoutCreditCard method", () {
    test(
      'test checkoutCreditCard method should return Success with SessionEntity',
      () async {
        when(
          dataSource.checkoutCreditCard(checkOutOrderRequest),
        ).thenAnswer((_) async => Success<SessionDto>(sessionDto));
        final result = await repo.checkoutCreditCard(checkOutOrderRequest);
        expect(result as Success<SessionEntity>, isA<Success<SessionEntity>>());
        expect(result.data.id, equals(sessionDto.id));
        expect(result.data.object, equals(sessionDto.object));
        expect(result.data.afterExpiration, equals(sessionDto.afterExpiration));
        expect(
          result.data.allowPromotionCodes,
          equals(sessionDto.allowPromotionCodes),
        );
        expect(result.data.amountTotal, equals(sessionDto.amountTotal));
        expect(result.data.amountTotal, equals(sessionDto.amountTotal));
        verify(dataSource.checkoutCreditCard(checkOutOrderRequest)).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
    test('test checkoutCreditCard method should return Failure ', () async {
      when(
        dataSource.checkoutCreditCard(checkOutOrderRequest),
      ).thenAnswer((_) async => Failure<SessionDto>(exception));
      final result = await repo.checkoutCreditCard(checkOutOrderRequest);
      expect(result as Failure<SessionEntity>, isA<Failure<SessionEntity>>());
      expect(result.errorMessage, equals(exception.toString()));
      verify(dataSource.checkoutCreditCard(checkOutOrderRequest)).called(1);
    });
  });
  group("test checkoutCash method", () {
    test(
      'test checkoutCash method should return Success with OrderEntity',
      () async {
        when(
          dataSource.checkoutCash(checkOutOrderRequest),
        ).thenAnswer((_) async => Success<OrderDto>(orderDto));
        final result = await repo.checkoutCash(checkOutOrderRequest);
        expect(result as Success<OrderEntity>, isA<Success<OrderEntity>>());
        expect(result.data.id, equals(orderDto.id));
        expect(result.data.totalPrice, equals(orderDto.totalPrice));
        expect(result.data.createdAt, equals(orderDto.createdAt));
        expect(result.data.updatedAt, equals(orderDto.updatedAt));
        expect(result.data.V, equals(orderDto.V));
        expect(result.data.orderNumber, equals(orderDto.orderNumber));
        expect(result.data.isPaid, equals(orderDto.isPaid));
        expect(result.data.isDelivered, equals(orderDto.isDelivered));
        expect(result.data.orderItems, equals(orderDto.orderItems));
        expect(result.data.paymentType, equals(orderDto.paymentType));
        expect(result.data.state, equals(orderDto.state));
        expect(result.data.state, equals(orderDto.state));
        expect(result.data.totalPrice, equals(orderDto.totalPrice));
        verify(dataSource.checkoutCash(checkOutOrderRequest)).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
    test('test checkoutCash method should return Failure ', () async {
      when(
        dataSource.checkoutCash(checkOutOrderRequest),
      ).thenAnswer((_) async => Failure<OrderDto>(exception));
      final result = await repo.checkoutCash(checkOutOrderRequest);
      expect(result as Failure<OrderEntity>, isA<Failure<OrderEntity>>());
      expect(result.errorMessage, equals(exception.toString()));
      verify(dataSource.checkoutCash(checkOutOrderRequest)).called(1);
    });
  });
  group("test getUserAddresses method", () {
    test(
      "test getUserAddresses method should return Success with AddressEntity",
      () async {
        when(dataSource.getUserAddresses()).thenAnswer(
          (_) async => Success<List<AddressesDto>>(addressesDtoList),
        );

        final result = await repo.getUserAddresses();
        expect(result, isA<Success<List<AddressesEntity>>>());
        expect(
          (result as Success<List<AddressesEntity>>).data.length,
          equals(addressesDtoList.length),
        );

        for (int i = 0; i < addressesDtoList.length; i++) {
          expect((result).data[i].street, equals(addressesDtoList[i].street));
          expect((result).data[i].phone, equals(addressesDtoList[i].phone));
          expect((result).data[i].city, equals(addressesDtoList[i].city));
          expect((result).data[i].lat, equals(addressesDtoList[i].lat));
          expect((result).data[i].long, equals(addressesDtoList[i].long));
          expect(
            (result).data[i].username,
            equals(addressesDtoList[i].username),
          );
          expect((result).data[i].id, equals(addressesDtoList[i].id));
        }

        verify(dataSource.getUserAddresses()).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
    test(
      "test getUserAddresses method should return Failure with exception",
      () async {
        when(
          dataSource.getUserAddresses(),
        ).thenAnswer((_) async => Failure<List<AddressesDto>>(exception));

        final result = await repo.getUserAddresses();
        expect(result, isA<Failure<List<AddressesEntity>>>());
        expect(
          (result as Failure<List<AddressesEntity>>).errorMessage,
          equals(exception),
        );
        verify(dataSource.getUserAddresses()).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
  });
}
