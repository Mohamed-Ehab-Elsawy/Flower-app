import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';

class CategoriesViewStates with EquatableMixin {
  final int selectedIndex;
  final BaseState<List<ProductTypeEntity>>? categories;
  final BaseState<List<ProductsEntity>>? productsStates;

  const CategoriesViewStates({
    this.selectedIndex = 0,
    this.categories,
    this.productsStates,
  });

  CategoriesViewStates copyWith({
    BaseState<List<ProductsEntity>>? productsStates,
    BaseState<List<ProductTypeEntity>>? categories,
    int? selectedIndex,
  }) => CategoriesViewStates(
    productsStates: productsStates ?? this.productsStates,
    categories: categories ?? this.categories,
    selectedIndex: selectedIndex ?? this.selectedIndex,
  );

  @override
  List<Object?> get props => [selectedIndex, categories, productsStates];
}
