import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/categories/presentation/view/manager/sort_enum.dart';

class CategoriesViewStates with EquatableMixin {
  final int selectedIndex;
  final String? selectedCategoryId;
  final BaseState<List<ProductTypeEntity>>? categories;
  final BaseState<List<ProductsEntity>>? productsStates;
  final SortBy sortBy;

  const CategoriesViewStates({
    this.selectedIndex = 0,
    this.selectedCategoryId,
    this.categories,
    this.productsStates,
    this.sortBy = SortBy.newest,
  });

  CategoriesViewStates copyWith({
    BaseState<List<ProductsEntity>>? productsStates,
    BaseState<List<ProductTypeEntity>>? categories,
    int? selectedIndex,
    String? selectedCategoryId,
    SortBy? sortBy,
  }) => CategoriesViewStates(
    productsStates: productsStates ?? this.productsStates,
    categories: categories ?? this.categories,
    selectedIndex: selectedIndex ?? this.selectedIndex,
    selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    sortBy: sortBy ?? this.sortBy,
  );

  @override
  List<Object?> get props => [
    selectedIndex,
    selectedCategoryId,
    categories,
    productsStates,
    sortBy,
  ];
}
