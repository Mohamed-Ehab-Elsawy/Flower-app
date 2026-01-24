import 'dart:async';

import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/categories/domain/usecases/get_categories_use_case.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_intents.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_states.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'categories_view_events.dart';

@injectable
class CategoriesViewCubit extends Cubit<CategoriesViewStates> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;

  final _uiEventsController =
      StreamController<CategoriesViewUIEvents>.broadcast();

  Stream<CategoriesViewUIEvents> get uiEvents => _uiEventsController.stream;

  CategoriesViewCubit(this._getCategoriesUseCase, this._getProductsUseCase)
    : super(const CategoriesViewStates());

  void doIntent(CategoriesViewIntents intent) {
    switch (intent) {
      case GetProductsByCategoryIntent():
        _getAllProductsByOccasions(categoryId: intent.categoryId);
      case InitCategoriesViewIntent():
        _init(intent.index);
    }
  }

  _getAllProductsByOccasions({String? categoryId}) async {
    emit(
      state.copyWith(
        productsStates: const BaseState(requestState: RequestState.loading),
      ),
    );

    var response = await _getProductsUseCase(categoryId: categoryId);
    switch (response) {
      case Success<List<ProductsEntity>>():
        emit(state.copyWith(productsStates: BaseState.loaded(response.data)));

      case Failure<List<ProductsEntity>>():
        emit(
          state.copyWith(
            productsStates: BaseState.error(response.errorMessage),
          ),
        );
        _uiEventsController.add(
          CategoriesViewShowErrorEvent(response.errorMessage),
        );
    }
  }

  Future<void> _init(int? index) async {
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
          _getAllProductsByOccasions(categoryId: categories[index].id);
        }
      case Failure<List<ProductTypeEntity>>():
        emit(state.copyWith(categories: BaseState.error(result.errorMessage)));
        _uiEventsController.add(
          CategoriesViewShowErrorEvent(result.errorMessage),
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
