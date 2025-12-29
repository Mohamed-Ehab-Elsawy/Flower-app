import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_item_entity.dart';

class BestSellerEntity extends Equatable {
  final String? massage;
  final List<BestSellerItemEntity>? bestSellerItemEntityList;

  const BestSellerEntity({this.massage, this.bestSellerItemEntityList});
  @override
  List<Object?> get props => [massage, bestSellerItemEntityList];
}
