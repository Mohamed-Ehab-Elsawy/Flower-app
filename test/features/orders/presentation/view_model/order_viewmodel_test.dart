import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/base_response_result_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/domain/repositories/order_repo.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'order_viewmodel_test.mocks.dart';

@GenerateMocks([OrderRepo])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});

    // Updated approach using TestDefaultBinaryMessenger
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
          (call) async {
            if (call.method == 'read') {
              return 'mock_token';
            }
            return null;
          },
        );
  });

  late OrderViewModel orderViewModel;
  late OrderRepo orderRepo;

  setUp(() {
    orderRepo = MockOrderRepo();
    orderViewModel = OrderViewModel(orderRepo);
  });

  const testProduct = ProductsEntity(id: 'product_1');

  const testCartItem = CartItemEntity(
    id: 'product_1',
    product: testProduct,
    price: 80.0,
    quantity: 1,
  );

  final successCartResponse = Success(
    const CartResponseEntity(cart: CartEntity(items: [testCartItem])),
  );

  final failureCartResponse = Failure<CartResponseEntity>("error");
  final successClearResponse = Success(
    const SuccessResponseDto(message: "success"),
  );
  final failureClearResponse = Failure<SuccessResponseDto>("error");

  group("TEST OrderViewModel - GetOrders", () {
    blocTest<OrderViewModel, OrderState>(
      'emits [loading, loaded] when GetOrders is triggered successfully',
      build: () => orderViewModel,
      setUp: () {
        provideDummy<Result<CartResponseEntity>>(successCartResponse);
        when(
          orderRepo.getOrders(),
        ).thenAnswer((_) async => successCartResponse);
      },
      act: (bloc) => bloc.doIntent(GetOrders()),
      expect: () {
        var state = OrderState(ordes: BaseState.init());
        final Map<String, CartItemEntity> ordersMap = {
          'product_1': testCartItem,
        };
        return [
          state.copyWith(
            ordes: const BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.loading,
            ),
          ),
          state.copyWith(
            ordes: BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.loaded,
              data: ordersMap,
            ),
            cartOrders: BaseState<CartResponseEntity>(
              requestState: RequestState.loaded,
              data: successCartResponse.data,
            ),
          ),
        ];
      },
    );

    blocTest<OrderViewModel, OrderState>(
      'emits [loading, error] when GetOrders fails',
      build: () => orderViewModel,
      setUp: () {
        provideDummy<Result<CartResponseEntity>>(failureCartResponse);
        when(
          orderRepo.getOrders(),
        ).thenAnswer((_) async => failureCartResponse);
      },
      act: (bloc) => bloc.doIntent(GetOrders()),
      expect: () {
        var state = OrderState(ordes: BaseState.init());
        return [
          state.copyWith(
            ordes: const BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.loading,
            ),
          ),
          state.copyWith(
            ordes: BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.error,
              errorMessage: failureCartResponse.errorMessage,
            ),
          ),
        ];
      },
    );
  });

  group("TEST OrderViewModel - RemoveProductFromCart", () {
    blocTest<OrderViewModel, OrderState>(
      'emits [loaded] when RemoveProductFromCart is triggered successfully',
      build: () => orderViewModel,
      seed: () =>
          OrderState(ordes: BaseState.loaded({'product_1': testCartItem})),
      setUp: () {
        provideDummy<Result<CartResponseEntity>>(successCartResponse);
        when(
          orderRepo.removeSpecificProductFromCart('product_1'),
        ).thenAnswer((_) async => successCartResponse);
      },
      act: (bloc) =>
          bloc.doIntent(RemoveProductFromCart(productId: 'product_1')),
      expect: () {
        var state = OrderState(
          ordes: BaseState.loaded({'product_1': testCartItem}),
        );
        final Map<String, CartItemEntity> emptyMap = {};
        return [
          state.copyWith(
            ordes: BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.loaded,
              data: emptyMap,
            ),
          ),
        ];
      },
    );

    blocTest<OrderViewModel, OrderState>(
      'emits [loaded, error] when RemoveProductFromCart fails',
      build: () => orderViewModel,
      seed: () =>
          OrderState(ordes: BaseState.loaded({'product_1': testCartItem})),
      setUp: () {
        provideDummy<Result<CartResponseEntity>>(failureCartResponse);
        when(
          orderRepo.removeSpecificProductFromCart('product_1'),
        ).thenAnswer((_) async => failureCartResponse);
      },
      act: (bloc) =>
          bloc.doIntent(RemoveProductFromCart(productId: 'product_1')),
      expect: () {
        var state = OrderState(
          ordes: BaseState.loaded({'product_1': testCartItem}),
        );
        final Map<String, CartItemEntity> emptyMap = {};
        return [
          state.copyWith(
            ordes: BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.loaded,
              data: emptyMap,
            ),
          ),
          state.copyWith(
            ordes: BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.error,
              errorMessage: failureCartResponse.errorMessage,
            ),
          ),
        ];
      },
    );
  });

  group("TEST OrderViewModel - ClearCart", () {
    blocTest<OrderViewModel, OrderState>(
      'emits [loading, loaded] when ClearCart is triggered successfully',
      build: () => orderViewModel,
      seed: () =>
          OrderState(ordes: BaseState.loaded({'product_1': testCartItem})),
      setUp: () {
        provideDummy<Result<SuccessResponseDto>>(successClearResponse);
        when(
          orderRepo.clearCart(),
        ).thenAnswer((_) async => successClearResponse);
      },
      act: (bloc) => bloc.doIntent(ClearCart()),
      expect: () {
        var state = OrderState(
          ordes: BaseState.loaded({'product_1': testCartItem}),
        );
        final Map<String, CartItemEntity> emptyMap = {};
        return [
          state.copyWith(
            ordes: const BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.loading,
            ),
          ),
          state.copyWith(
            ordes: BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.loaded,
              data: emptyMap,
            ),
          ),
        ];
      },
    );

    blocTest<OrderViewModel, OrderState>(
      'emits [loading, error] when ClearCart fails',
      build: () => orderViewModel,
      setUp: () {
        provideDummy<Result<SuccessResponseDto>>(failureClearResponse);
        when(
          orderRepo.clearCart(),
        ).thenAnswer((_) async => failureClearResponse);
      },
      act: (bloc) => bloc.doIntent(ClearCart()),
      expect: () {
        var state = OrderState(ordes: BaseState.init());
        return [
          state.copyWith(
            ordes: const BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.loading,
            ),
          ),
          state.copyWith(
            ordes: BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.error,
              errorMessage: failureClearResponse.errorMessage,
            ),
          ),
        ];
      },
    );
  });

  group("TEST OrderViewModel - UpdateProductQuantity", () {
    blocTest<OrderViewModel, OrderState>(
      'calls updateCartProductQuantity when UpdateProductQuantity is triggered',
      build: () => orderViewModel,
      seed: () =>
          OrderState(ordes: BaseState.loaded({'product_1': testCartItem})),
      setUp: () {
        provideDummy<Result<CartResponseEntity>>(successCartResponse);
        when(
          orderRepo.updateCartProductQuantity('product_1', 2),
        ).thenAnswer((_) async => successCartResponse);
      },
      act: (bloc) => bloc.doIntent(
        UpdateProductQuantity(productId: 'product_1', quantity: 2),
      ),
      wait: const Duration(milliseconds: 700),
      expect: () => [],
      verify: (bloc) {
        verify(orderRepo.updateCartProductQuantity('product_1', 2)).called(1);
      },
    );

    blocTest<OrderViewModel, OrderState>(
      'emits [error] when UpdateProductQuantity fails',
      build: () => orderViewModel,
      seed: () =>
          OrderState(ordes: BaseState.loaded({'product_1': testCartItem})),
      setUp: () {
        provideDummy<Result<CartResponseEntity>>(failureCartResponse);
        when(
          orderRepo.updateCartProductQuantity('product_1', 2),
        ).thenAnswer((_) async => failureCartResponse);
      },
      act: (bloc) => bloc.doIntent(
        UpdateProductQuantity(productId: 'product_1', quantity: 2),
      ),
      wait: const Duration(milliseconds: 700),
      expect: () {
        var state = OrderState(
          ordes: BaseState.loaded({'product_1': testCartItem}),
        );
        return [
          state.copyWith(
            ordes: BaseState<Map<String, CartItemEntity>>(
              requestState: RequestState.error,
              errorMessage: failureCartResponse.errorMessage,
            ),
          ),
        ];
      },
    );
  });
}
