import 'dart:async';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/usecases/fetch_home_data_usecase.dart';
import 'package:flower_app/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final FetchHomeDataUsecase _homeUseCase;

  HomeViewModel(this._homeUseCase) : super(HomeState(BaseState.init()));
  final _uiEventsController = StreamController<HomeUIEvents>.broadcast();

  Stream<HomeUIEvents> get uiEventsStream => _uiEventsController.stream;

  void doIntent(Intent intent) {
    switch (intent) {
      case FetchHomeData():
        _fetchHomeData();
    }
  }

  void doEvent(HomeUIEvents event) {
    switch (event) {
      case ViewAllCategoriesEvent():
        _uiEventsController.add(ViewAllCategoriesEvent(index: event.index));

      case ViewAllOccasionsEvent():
        _uiEventsController.add(
          ViewAllOccasionsEvent(occasions: event.occasions),
        );

      case ItemBestSellerSelectedEvent():
        _uiEventsController.add(
          ItemBestSellerSelectedEvent(product: event.product),
        );
      case ViewAllBestSellerEvent():
        _uiEventsController.add(ViewAllBestSellerEvent());
    }
  }

  Future<void> _fetchHomeData() async {
    emit(
      state.copyWith(
        const BaseState<HomeResponseEntity>(requestState: RequestState.loading),
      ),
    );
    final result = await _homeUseCase.call();
    switch (result) {
      case Success<HomeResponseEntity>():
        emit(state.copyWith(BaseState.loaded(result.data)));
      case Failure<HomeResponseEntity>():
        emit(state.copyWith(BaseState.error(result.errorMessage)));
    }
  }
}

sealed class Intent {}

class FetchHomeData extends Intent {}

sealed class HomeUIEvents {}

class ViewAllCategoriesEvent extends HomeUIEvents {
  final int index;

  ViewAllCategoriesEvent({required this.index});
}

class ViewAllOccasionsEvent extends HomeUIEvents {
  final List<ProductTypeEntity>? occasions;

  ViewAllOccasionsEvent({this.occasions});
}

class ViewAllBestSellerEvent extends HomeUIEvents {
  final List<ProductTypeEntity>? occasions;

  ViewAllBestSellerEvent({this.occasions});
}

class ItemBestSellerSelectedEvent extends HomeUIEvents {
  final ProductsEntity? product;

  ItemBestSellerSelectedEvent({this.product});
}
