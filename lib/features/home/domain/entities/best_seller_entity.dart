import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';

class BestSellerEntity extends Equatable {
  final String? massage;
  final List<ProductsEntity>? bestSellerItemEntityList;

  const BestSellerEntity({this.massage, this.bestSellerItemEntityList});
  @override
  List<Object?> get props => [massage, bestSellerItemEntityList];
}
