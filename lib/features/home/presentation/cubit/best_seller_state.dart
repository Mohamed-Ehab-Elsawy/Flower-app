import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';

class BestSellerState extends Equatable {
  final BaseState<List<ProductsEntity>> bestSellerState;

  const BestSellerState({required this.bestSellerState});
  BestSellerState copyWith({
    required BaseState<List<ProductsEntity>>? bestSellerState,
  }) =>
      BestSellerState(bestSellerState: bestSellerState ?? this.bestSellerState);
  @override
  List<Object?> get props => [bestSellerState];
}

sealed class BestSellerIntent {}

class GetBestSellerIntent extends BestSellerIntent {}

class NavigateToProductDetailsIntent extends BestSellerIntent {
  final ProductsEntity productId;
  NavigateToProductDetailsIntent({required this.productId});
}

class NavigateToHomeIntent extends BestSellerIntent {}

class AddToCartIntent extends BestSellerIntent {
  final String productId;
  AddToCartIntent({required this.productId});
}
