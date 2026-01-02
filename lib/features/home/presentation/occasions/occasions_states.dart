import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/product_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';

class OccasionsStates extends Equatable {
  final BaseState<List<ProductEntity>>? productsState;
  const OccasionsStates({this.productsState});
  @override
  List<Object?> get props => [productsState];
  OccasionsStates copyWith({BaseState<List<ProductEntity>>? productsState}) {
    return OccasionsStates(productsState: productsState ?? this.productsState);
  }
}
