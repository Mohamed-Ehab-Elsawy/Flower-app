import 'dart:async';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/usecases/get_best_seller_use_case.dart';
import 'package:flower_app/features/home/presentation/cubit/best_seller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BestSellerViewModel extends Cubit<BestSellerState> {
  final GetBestSellerUseCase _getBestSellerUseCase;
  BestSellerViewModel(this._getBestSellerUseCase)
    : super(BestSellerState(bestSellerState: BaseState.init()));
  final _uiEventsController = StreamController<BestSellerIntent>.broadcast();

  Stream<BestSellerIntent> get uiEventsStream => _uiEventsController.stream;

  void doIntent(BestSellerIntent event) {
    switch (event) {
      case GetBestSellerIntent():
        _getBestSeller();

      case NavigateToProductDetailsIntent():
        _uiEventsController.add(
          NavigateToProductDetailsIntent(productId: event.productId),
        );
      case AddToCartIntent():
        _uiEventsController.add(AddToCartIntent(productId: event.productId));
      case NavigateToHomeIntent():
        _uiEventsController.add(NavigateToHomeIntent());
    }
  }

  Future<void> _getBestSeller() async {
    emit(BestSellerState(bestSellerState: BaseState.loading()));
    final result = await _getBestSellerUseCase.invoke();
    switch (result) {
      case Success<List<ProductsEntity>>():
        emit(BestSellerState(bestSellerState: BaseState.loaded(result.data)));
      case Failure<List<ProductsEntity>>():
        emit(
          BestSellerState(
            bestSellerState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
