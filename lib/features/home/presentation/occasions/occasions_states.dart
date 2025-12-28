import 'package:flower_app/core/bloc_box/base_state.dart';

import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class OccasionsStates {
  BaseState<List<ProductsEntity>>? productsStates;
  OccasionsStates({this.productsStates});

  OccasionsStates copyWith({BaseState<List<ProductsEntity>>? productsState}) {
    return OccasionsStates(productsStates: productsState ?? productsStates);
  }
}
