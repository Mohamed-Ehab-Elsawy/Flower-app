import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class CategoriesViewStates {
  final int selectedIndex;
  final List<String>? categories;
  final BaseState<List<ProductsEntity>>? productsStates;

  const CategoriesViewStates({
    this.selectedIndex = 0,
    this.categories,
    this.productsStates,
  });

  CategoriesViewStates copyWith({
    BaseState<List<ProductsEntity>>? productsState,
    List<String>? categories,
    int? selectedIndex,
  }) => CategoriesViewStates(
    productsStates: productsState ?? productsStates,
    categories: categories ?? this.categories,
    selectedIndex: selectedIndex ?? this.selectedIndex,
  );
}
