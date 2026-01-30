import 'dart:async';

import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/categories/domain/usecases/get_categories_use_case.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_intents.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_states.dart';
import 'package:flower_app/features/categories/presentation/view/manager/sort_enum.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'categories_view_events.dart';

@injectable
class CategoriesViewModel extends Cubit<CategoriesViewStates> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;

  final _uiEventsController =
      StreamController<CategoriesViewUIEvents>.broadcast();

  Stream<CategoriesViewUIEvents> get uiEvents => _uiEventsController.stream;

  CategoriesViewModel(this._getCategoriesUseCase, this._getProductsUseCase)
    : super(const CategoriesViewStates());

  void doIntent(CategoriesViewIntents intent) {
    switch (intent) {
      case InitCategoriesViewIntent():
        _init(intent.index);
      case GetProductsByCategoryIntent():
        _getAllProductsByCategories(categoryId: intent.categoryId);
      case CategoriesFilterIntent():
        _chooseFilter(intent.sortBy);
      case GetProductByFilterIntent():
        _getProductsByFilter();
    }
  }

  _init(int? index) async {
    emit(
      state.copyWith(
        categories: const BaseState(requestState: RequestState.loading),
        selectedIndex: index,
      ),
    );

    final result = await _getCategoriesUseCase();

    switch (result) {
      case Success<List<ProductTypeEntity>>():
        final categories = result.data;

        emit(state.copyWith(categories: BaseState.loaded(categories)));

        if (index != null && index >= 0 && index < categories.length) {
          _getAllProductsByCategories(categoryId: categories[index].id ?? '');
        }
      case Failure<List<ProductTypeEntity>>():
        emit(state.copyWith(categories: BaseState.error(result.errorMessage)));
        _uiEventsController.add(
          CategoriesViewShowErrorEvent(result.errorMessage),
        );
    }
  }

  _getAllProductsByCategories({required String categoryId}) async {
    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        productsStates: const BaseState(requestState: RequestState.loading),
      ),
    );
    late String sortId;
    switch (state.sortBy) {
      case SortBy.priceLowToHigh:
        sortId = "price";
      case SortBy.priceHighToLow:
        sortId = "-price";
      case SortBy.newest:
        sortId = "-updatedAt";
      case SortBy.oldest:
        sortId = "updatedAt";
      case SortBy.discountFirst:
        sortId = "-discount";
    }
    final response = await _getProductsUseCase(
      sort: sortId,
      categoryId: categoryId,
    );

    switch (response) {
      case Success<List<ProductsEntity>>():
        emit(state.copyWith(productsStates: BaseState.loaded(response.data)));
      case Failure<List<ProductsEntity>>():
        emit(
          state.copyWith(
            productsStates: BaseState.error(response.errorMessage),
          ),
        );
    }
  }

  _chooseFilter(SortBy sortBy) => emit(state.copyWith(sortBy: sortBy));

  _getProductsByFilter() async {
    final categoryId = state.selectedCategoryId;

    late String sortId;
    switch (state.sortBy) {
      case SortBy.priceLowToHigh:
        sortId = "price";
      case SortBy.priceHighToLow:
        sortId = "-price";
      case SortBy.newest:
        sortId = "-updatedAt";
      case SortBy.oldest:
        sortId = "updatedAt";
      case SortBy.discountFirst:
        sortId = "-discount";
    }

    emit(
      state.copyWith(
        productsStates: const BaseState(requestState: RequestState.loading),
      ),
    );

    final response = await _getProductsUseCase(
      categoryId: categoryId,
      sort: sortId,
    );

    switch (response) {
      case Success<List<ProductsEntity>>():
        emit(state.copyWith(productsStates: BaseState.loaded(response.data)));
      case Failure<List<ProductsEntity>>():
        emit(
          state.copyWith(
            productsStates: BaseState.error(response.errorMessage),
          ),
        );
    }
  }

  List<Object> get props {
    return [state];
  }

  @override
  Future<void> close() {
    _uiEventsController.close();
    return super.close();
  }
}
