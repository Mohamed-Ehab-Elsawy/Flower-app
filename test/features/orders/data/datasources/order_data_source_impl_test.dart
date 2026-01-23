import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/base_response_result_dto.dart';
import 'package:flower_app/core/error_handling/failures.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/orders/data/datasources/order_data_source.dart';
import 'package:flower_app/features/orders/data/datasources/order_data_source_impl.dart';
import 'package:flower_app/features/orders/data/models/cart_request_dto.dart';
import 'package:flower_app/features/orders/data/models/order_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late ApiClient mockApiClient;
  late OrderDataSource orderDataSourceImpl;
  setUp(() {
    mockApiClient = MockApiClient();
    orderDataSourceImpl = OrderDataSourceImpl(mockApiClient);
  });

  group("Test Order DataSource Impl with Success", () {
    test("Test addProductToCart", () async {
      const tcartRequestDto = CartRequestDto(productId: '1', quantity: 1);
      const tcartItemDto = CartItemDto(id: '1', quantity: 1);

      const tcartResponse = CartResponseDto(message: 'message');
      when(
        mockApiClient.addProductToCart(tcartRequestDto),
      ).thenAnswer((_) async => tcartResponse);
      final result =
          await orderDataSourceImpl.addProductToCart(tcartItemDto)
              as Success<CartResponseDto>;
      expect(result, isA<Result<CartResponseDto>>());
    });
    test("Test clearCart", () async {
      const tcartResponse = SuccessResponseDto(message: "success");
      when(mockApiClient.clearCart()).thenAnswer((_) async => tcartResponse);
      final result =
          await orderDataSourceImpl.clearCart() as Success<SuccessResponseDto>;
      expect(result, isA<Result<SuccessResponseDto>>());
    });
    test("Test getOrders", () async {
      const tcartResponse = CartResponseDto(message: "success");
      when(
        mockApiClient.getLoggedUserCart(),
      ).thenAnswer((_) async => tcartResponse);
      final result =
          await orderDataSourceImpl.getOrders() as Success<CartResponseDto>;
      expect(result, isA<Result<CartResponseDto>>());
    });
    test("Test removeSpecificProductFromCart", () async {
      const tcartResponse = CartResponseDto(message: "success");
      when(
        mockApiClient.removeProductFromCart("1"),
      ).thenAnswer((_) async => tcartResponse);
      final result =
          await orderDataSourceImpl.removeSpecificProductFromCart("1")
              as Success<CartResponseDto>;
      expect(result, isA<Result<CartResponseDto>>());
    });
    test("Test updateCartProductQuantity", () async {
      const tcartResponse = CartResponseDto(message: "success");
      when(
        mockApiClient.updateProductQuantity("1", {"quantity": 1}),
      ).thenAnswer((_) async => tcartResponse);
      final result =
          await orderDataSourceImpl.updateCartProductQuantity("1", 1)
              as Success<CartResponseDto>;
      expect(result, isA<Result<CartResponseDto>>());
    });
  });

  group("Test Order DataSource Impl with Failure", () {
    late AppFailure tAppFailure;
    late String errorMessage;
    setUp(() {
      errorMessage = "unexpected error";
      tAppFailure = UnexpectedFailure(errorMessage);
    });
    test("Test addProductToCart should throw failure result", () async {
      const tcartRequestDto = CartRequestDto(productId: '1', quantity: 1);
      const tcartItemDto = CartItemDto(id: '1', quantity: 1);

      when(
        mockApiClient.addProductToCart(tcartRequestDto),
      ).thenThrow(tAppFailure);
      final result =
          await orderDataSourceImpl.addProductToCart(tcartItemDto)
              as Failure<CartResponseDto>;
      expect(result, isA<Result<CartResponseDto>>());
    });
    test("Test clearCart should throw failure result", () async {
      when(mockApiClient.clearCart()).thenThrow(tAppFailure);
      final result =
          await orderDataSourceImpl.clearCart() as Failure<SuccessResponseDto>;
      expect(result, isA<Result<SuccessResponseDto>>());
      expect(result.errorMessage, isA<String>());
    });
    test("Test getOrders should throw failure result", () async {
      when(mockApiClient.getLoggedUserCart()).thenThrow(tAppFailure);
      final result =
          await orderDataSourceImpl.getOrders() as Failure<CartResponseDto>;
      expect(result, isA<Result<CartResponseDto>>());
      expect(result.errorMessage, isA<String>());
    });
    test(
      "Test removeSpecificProductFromCart should throw failure result",
      () async {
        when(mockApiClient.removeProductFromCart("1")).thenThrow(tAppFailure);
        final result =
            await orderDataSourceImpl.removeSpecificProductFromCart("1")
                as Failure<CartResponseDto>;
        expect(result, isA<Result<CartResponseDto>>());
        expect(result.errorMessage, isA<String>());
      },
    );
    test(
      "Test updateCartProductQuantity should throw failure result",
      () async {
        when(
          mockApiClient.updateProductQuantity("1", {"quantity": 1}),
        ).thenThrow(tAppFailure);
        final result =
            await orderDataSourceImpl.updateCartProductQuantity("1", 1)
                as Failure<CartResponseDto>;
        expect(result, isA<Result<CartResponseDto>>());
        expect(result.errorMessage, isA<String>());
      },
    );
  });
}
