import 'dart:async';

import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/base_response_result_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/domain/repositories/order_repo.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OrderViewModel extends Cubit<OrderState> {
  final OrderRepo _orderRepo;
  Timer? _timer;
  final _uiEventsController = StreamController<UiEvents>.broadcast();

  Stream<UiEvents> get uiEventsStream => _uiEventsController.stream;
  OrderViewModel(this._orderRepo) : super(OrderState(ordes: BaseState.init()));

  /// add item Local
  void _addItemToCart(ProductsEntity product) async {
    if (product.outOfStock) {
      emit(state.copyWith(ordes: BaseState.error('Product is out of stock')));
      return;
    }

    final currentMap = Map<String, CartItemEntity>.from(
      state.ordes?.data ?? {},
    );

    final cartItem = CartItemEntity(
      id: product.id,
      product: product,
      price: product.priceHasDiscount,
      quantity: 1,
    );

    currentMap[product.id!] = cartItem;

    emit(state.copyWith(ordes: BaseState.loaded(currentMap)));

    final response = await _orderRepo.addProductToCart(cartItem);

    switch (response) {
      case Success<CartResponseEntity>():
        final cartItems = response.data.cart?.items ?? [];

        final Map<String, CartItemEntity> ordersMap = {
          for (final item in cartItems)
            if (item.product?.id != null) item.product!.id!: item,
        };

        emit(state.copyWith(ordes: BaseState.loaded(ordersMap)));

      case Failure<CartResponseEntity>():
        emit(state.copyWith(ordes: BaseState.error(response.errorMessage)));
    }
  }

  void _removeProductFromCart(String productId) async {
    final currentMap = Map<String, CartItemEntity>.from(
      state.ordes?.data ?? {},
    );

    currentMap.remove(productId);

    emit(state.copyWith(ordes: BaseState.loaded(currentMap)));

    final response = await _orderRepo.removeSpecificProductFromCart(productId);

    switch (response) {
      case Success<CartResponseEntity>():
        break;

      case Failure<CartResponseEntity>():
        emit(state.copyWith(ordes: BaseState.error(response.errorMessage)));
    }
  }

  void _updateProductQuantity({
    required String productId,
    required int quantity,
  }) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 600), () async {
      final response = await _orderRepo.updateCartProductQuantity(
        productId,
        quantity,
      );
      _timer?.cancel();

      // Get current item
      final currentMap = Map<String, CartItemEntity>.from(
        state.ordes?.data ?? {},
      );
      final item = currentMap[productId];

      if (item == null) return;

      // Use entity's copyWith method
      final updatedItem = item.copyWith(quantity: quantity);
      currentMap[productId] = updatedItem;

      currentMap[productId] = item.copyWith(quantity: quantity);

      switch (response) {
        case Success<CartResponseEntity>():
          final cartItems = response.data.cart?.items ?? [];
          final Map<String, CartItemEntity> ordersMap = {
            for (final item in cartItems)
              if (item.product?.id != null) item.product!.id!: item,
          };

          if (isClosed) return;
          emit(state.copyWith(ordes: BaseState.loaded(ordersMap)));

        case Failure<CartResponseEntity>():
          if (isClosed) return;
          emit(state.copyWith(ordes: BaseState.error(response.errorMessage)));
      }
    });
  }

  void _clearCart() async {
    emit(state.copyWith(ordes: BaseState.loading()));
    final response = await _orderRepo.clearCart();
    switch (response) {
      case Success<SuccessResponseDto>():
        Map<String, CartItemEntity> ordersMap = Map.from(
          state.ordes?.data ?? {},
        );
        ordersMap.clear();
        emit(state.copyWith(ordes: BaseState.loaded(ordersMap)));
      case Failure<SuccessResponseDto>():
        emit(state.copyWith(ordes: BaseState.error(response.errorMessage)));
    }
  }

  void _getOrders() async {
    emit(state.copyWith(ordes: BaseState.loading()));
    final response = await _orderRepo.getOrders();

    switch (response) {
      case Success<CartResponseEntity>():
        //upDataBillState

        //this is the response from the server [old orders]
        final cartItems = response.data.cart?.items ?? [];

        ///  List -> Map
        final Map<String, CartItemEntity> ordersMap = {
          for (final item in cartItems)
            if (item.product?.id != null) ?item.product!.id: item,
        };
        emit(
          state.copyWith(
            ordes: BaseState.loaded(ordersMap),
            cartOrders: BaseState.loaded(response.data),
          ),
        );
      case Failure<CartResponseEntity>():
        emit(state.copyWith(ordes: BaseState.error(response.errorMessage)));
    }
  }

  void doIntent(Intent intent) {
    switch (intent) {
      case GetOrders():
        _getOrders();

      case ClearCart():
        _clearCart();
      case UpdateProductQuantity():
        _updateProductQuantity(
          productId: intent.productId,
          quantity: intent.quantity,
        );
      case AddItemToCart():
        _addItemToCart(intent.product);
        _addAction();
      case RemoveProductFromCart():
        _removeProductFromCart(intent.productId);
    }
  }

  void _addAction() {

        _uiEventsController.add(AddToCartEvent());

  }

  dispose() {
    _timer?.cancel();
    _uiEventsController.close();
    super.close();
  }
}
