import 'dart:async';

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

  Future<void> _fetchHomeData() async {
    emit(state.copyWith(homeState: BaseState.loading()));
    final result = await _homeUseCase.call();
    switch (result) {
      case Success<HomeResponseEntity>():
        emit(state.copyWith(homeState: BaseState.loaded(result.data)));
      case Failure<HomeResponseEntity>():
        emit(state.copyWith(homeState: BaseState.error(result.errorMessage)));
    }
  }
}

sealed class Intent {}

class FetchHomeData extends Intent {}

sealed class HomeUIEvents {}

class ViewAllCategoriesEvent extends HomeUIEvents {}

class ViewAllBestSellerEvent extends HomeUIEvents {}

class ViewAllOccasionsEvent extends HomeUIEvents {}
