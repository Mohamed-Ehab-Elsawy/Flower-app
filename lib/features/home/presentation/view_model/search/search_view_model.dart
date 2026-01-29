import 'dart:async';

import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flower_app/features/home/presentation/view_model/search/search_intent.dart';
import 'package:flower_app/features/home/presentation/view_model/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchViewModel extends Cubit<SearchState> {
  final GetProductsUseCase _getProductsUseCase;
  final _uiEventsController = StreamController<SearchUIEvents>.broadcast();
  Stream<SearchUIEvents> get uiEventsStream => _uiEventsController.stream;

  SearchViewModel(this._getProductsUseCase) : super(SearchState.initial());
  Timer? _debounce;

  void doIntent(SearchIntent intent) {
    switch (intent) {
      case SearchKeywordChanged():
        _onKeywordChanged(intent.keyword);
      case SearchCleared():
        _onClear();
      case ProductTapped():
        _onProductTapped(intent.product);
    }
  }

  void _onKeywordChanged(String keyword) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    final cleanKeyword = keyword.trim();

    if (cleanKeyword.isEmpty) {
      emit(SearchState.initial());
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _getSearch(cleanKeyword);
    });
  }

  Future<void> _getSearch(String keyword) async {
    emit(state.copyWith(searchState: state.searchState.loading));
    final response = await _getProductsUseCase(keyword: keyword);
    switch (response) {
      case Success<List<ProductsEntity>>():
        emit(
          state.copyWith(searchState: state.searchState.loaded(response.data)),
        );
      case Failure<List<ProductsEntity>>():
        emit(
          state.copyWith(
            searchState: state.searchState.error(response.errorMessage),
          ),
        );
    }
  }
  void _onProductTapped(ProductsEntity product) =>
    _uiEventsController.add(OpenProductDetails(product: product));


  void _onClear() {
    _debounce?.cancel();
    emit(SearchState.initial());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
