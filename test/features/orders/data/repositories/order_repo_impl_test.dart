import 'package:flower_app/core/error_handling/base_response_result_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/orders/data/datasources/order_data_source.dart';
import 'package:flower_app/features/orders/data/mapper/order_mapper.dart';
import 'package:flower_app/features/orders/data/models/order_response_dto.dart';
import 'package:flower_app/features/orders/data/repositories/order_repo_impl.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/domain/repositories/order_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_repo_impl_test.mocks.dart';

@GenerateMocks([OrderDataSource])
void main() {
  late OrderDataSource mockDataSource;
  late OrderRepo orderRepoImpl;
  setUp(() {
    mockDataSource = MockOrderDataSource();
    orderRepoImpl = OrderRepoImpl(mockDataSource);
  });

  group("Test Order Repo Impl with Success", () {
    test("Test addProductToCart repo ", () async {
      //arrange

      const tCartResponseDto = CartResponseDto(message: "success");
      const tCartItemDto = CartItemDto(id: '1', quantity: 1);

      final successResponse = Success<CartResponseDto>(tCartResponseDto);
      provideDummy<Result<CartResponseDto>>(successResponse);

      //act

      when(
        mockDataSource.addProductToCart(tCartItemDto),
      ).thenAnswer((_) async => successResponse);
      final result =
          await orderRepoImpl.addProductToCart(tCartItemDto.toEntity())
              as Success<CartResponseEntity>;

      //assert
      expect(result, isA<Result<CartResponseEntity>>());
      expect(result.data, isA<CartResponseEntity>());
    });

    test("Test clearCart", () async {
      const tSuccessResponseDto = SuccessResponseDto(message: "success");
      final successResponse = Success<SuccessResponseDto>(tSuccessResponseDto);
      provideDummy<Result<SuccessResponseDto>>(successResponse);
      when(mockDataSource.clearCart()).thenAnswer((_) async => successResponse);
      var result =
          await orderRepoImpl.clearCart() as Success<SuccessResponseDto>;
      expect(result, isA<Result<SuccessResponseDto>>());
    });

    test("Test getOrders", () async {
      const tcartResponse = CartResponseDto(message: "success");
      final successResponse = Success<CartResponseDto>(tcartResponse);
      provideDummy<Result<CartResponseDto>>(successResponse);
      when(mockDataSource.getOrders()).thenAnswer((_) async => successResponse);
      final result =
          await orderRepoImpl.getOrders() as Success<CartResponseEntity>;
      expect(result, isA<Result<CartResponseEntity>>());
    });
    test("Test removeSpecificProductFromCart", () async {
      const tcartResponse = CartResponseDto(message: "success");
      final successResponse = Success<CartResponseDto>(tcartResponse);
      provideDummy<Result<CartResponseDto>>(successResponse);
      when(
        mockDataSource.removeSpecificProductFromCart("1"),
      ).thenAnswer((_) async => successResponse);
      final result =
          await orderRepoImpl.removeSpecificProductFromCart("1")
              as Success<CartResponseEntity>;
      expect(result, isA<Result<CartResponseEntity>>());
    });
    test("Test updateCartProductQuantity", () async {
      const tcartResponse = CartResponseDto(message: "success");
      final successResponse = Success<CartResponseDto>(tcartResponse);
      provideDummy<Result<CartResponseDto>>(successResponse);
      when(
        mockDataSource.updateCartProductQuantity("1", 1),
      ).thenAnswer((_) async => successResponse);
      final result =
          await orderRepoImpl.updateCartProductQuantity("1", 1)
              as Success<CartResponseEntity>;
      expect(result, isA<Result<CartResponseEntity>>());
    });
  });

  group("Test Order Repo Impl with Failure", () {
    late String errorMessage;
    setUp(() {
      errorMessage = "unexpected error";
    });
    test("Test addProductToCart should return failure result", () async {
      final failureResult = Failure<CartResponseDto>(errorMessage);
      const tcartRequestDto = CartItemDto(id: '1', quantity: 1);
      provideDummy<Result<CartResponseDto>>(failureResult);
      when(
        mockDataSource.addProductToCart(tcartRequestDto),
      ).thenAnswer((_) async => failureResult);
      final result =
          await orderRepoImpl.addProductToCart(tcartRequestDto.toEntity())
              as Failure<CartResponseEntity>;
      expect(result, isA<Result<CartResponseEntity>>());
    });
    test("Test clearCart should return failure result", () async {
      final failureResult = Failure<SuccessResponseDto>(errorMessage);
      provideDummy<Result<SuccessResponseDto>>(failureResult);
      when(mockDataSource.clearCart()).thenAnswer((_) async => failureResult);
      final result =
          await orderRepoImpl.clearCart() as Failure<SuccessResponseDto>;
      expect(result, isA<Result<SuccessResponseDto>>());
      expect(result.errorMessage, isA<String>());
    });
    test("Test getOrders should return failure result", () async {
      final failureResult = Failure<CartResponseDto>(errorMessage);
      provideDummy<Result<CartResponseDto>>(failureResult);
      when(mockDataSource.getOrders()).thenAnswer((_) async => failureResult);
      final result =
          await orderRepoImpl.getOrders() as Failure<CartResponseEntity>;
      expect(result, isA<Result<CartResponseEntity>>());
      expect(result.errorMessage, isA<String>());
    });
    test(
      "Test removeSpecificProductFromCart should return failure result",
      () async {
        final failureResult = Failure<CartResponseDto>(errorMessage);
        provideDummy<Result<CartResponseDto>>(failureResult);
        when(
          mockDataSource.removeSpecificProductFromCart("1"),
        ).thenAnswer((_) async => failureResult);
        final result =
            await orderRepoImpl.removeSpecificProductFromCart("1")
                as Failure<CartResponseEntity>;
        expect(result, isA<Result<CartResponseEntity>>());
        expect(result.errorMessage, isA<String>());
      },
    );
    test(
      "Test updateCartProductQuantity should return failure result",
      () async {
        final failureResult = Failure<CartResponseDto>(errorMessage);
        provideDummy<Result<CartResponseDto>>(failureResult);
        when(
          mockDataSource.updateCartProductQuantity("1", 1),
        ).thenAnswer((_) async => failureResult);
        final result =
            await orderRepoImpl.updateCartProductQuantity("1", 1)
                as Failure<CartResponseEntity>;
        expect(result, isA<Result<CartResponseEntity>>());
        expect(result.errorMessage, isA<String>());
      },
    );
  });
}
