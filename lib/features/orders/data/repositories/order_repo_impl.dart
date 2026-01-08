import 'package:flower_app/core/error_handling/base_response_result_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/orders/data/datasources/order_data_source.dart';
import 'package:flower_app/features/orders/data/mapper/order_mapper.dart';
import 'package:flower_app/features/orders/data/models/order_response_dto.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/domain/repositories/order_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrderRepo)
class OrderRepoImpl implements OrderRepo{
  final OrderDataSource _orderDataSource;
  OrderRepoImpl(this._orderDataSource);
  @override
  Future<Result<CartResponseEntity>> addProductToCart(CartItemEntity cartItem)async {
    final response =await _orderDataSource.addProductToCart(cartItem.toDto());
    switch (response) {
      case Success<CartResponseDto>():
        final result= response.data.toEntity();
        return Success(result);
      case Failure<CartResponseDto>():
        return Failure(response.errorMessage);
    }
  }
  @override
  Future<Result<SuccessResponseDto>> clearCart()async {
    final response =await _orderDataSource.clearCart();
    switch (response) {

      case Success<SuccessResponseDto>():
        final result= response.data;
        return Success(result);
      case Failure<SuccessResponseDto>():
        return Failure(response.errorMessage);
    }
  }
  @override
  Future<Result<CartResponseEntity>> getOrders() async{
    final response =await _orderDataSource.getOrders();
    switch (response) {
      case Success<CartResponseDto>():
        final result= response.data.toEntity();
        return Success(result);
      case Failure<CartResponseDto>():
        return Failure(response.errorMessage);
    }

  }
  @override
  Future<Result<CartResponseEntity>> removeSpecificProductFromCart(String id) async{
    final response =await _orderDataSource.removeSpecificProductFromCart(id);
    switch (response) {
      case Success<CartResponseDto>():
        final result= response.data.toEntity();
        return Success(result);
      case Failure<CartResponseDto>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<CartResponseEntity>> updateCartProductQuantity(String id, int quantity)async {
    final response =await _orderDataSource.updateCartProductQuantity(id, quantity);
    switch (response) {
      case Success<CartResponseDto>():
        final result= response.data.toEntity();
        return Success(result);
      case Failure<CartResponseDto>():
        return Failure(response.errorMessage);
    }
  }
}