import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';

class BestSellerState extends Equatable {
  final BaseState<BestSellerEntity> bestSellerState;

  const BestSellerState({required this.bestSellerState});
  BestSellerState copyWith({
    required BaseState<BestSellerEntity>? bestSellerState,
  }) =>
      BestSellerState(bestSellerState: bestSellerState ?? this.bestSellerState);
  @override
  List<Object?> get props => [bestSellerState];
}

sealed class BestSellerIntent {}

class GetBestSellerIntent extends BestSellerIntent {}

class NavigateToProductDetailsIntent extends BestSellerIntent {
  final String productId;
  NavigateToProductDetailsIntent({required this.productId});
}

class AddToCartIntent extends BestSellerIntent {
  final String productId;
  AddToCartIntent({required this.productId});
}
