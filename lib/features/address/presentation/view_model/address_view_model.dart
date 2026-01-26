import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:flower_app/features/address/domain/usecase/load_city_usecase.dart';
import 'package:flower_app/features/address/presentation/view_model/address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressViewModel extends Cubit<AddressState> {
  final LoadCityUseCase _loadCityUseCase;

  AddressViewModel(this._loadCityUseCase)
    : super(
        AddressState(
          allData: BaseState.init(),
          filteredCities: BaseState.init(),
        ),
      );

  Future<void> loadInitialData(String lang) async {
    final result = await _loadCityUseCase(lang);
    switch (result) {
      case Success<Map<String, List<CityEntity>>>():
        final allData = result.data;
        emit(state.copyWith(allData: BaseState.loaded(allData)));

      case Failure<Map<String, List<CityEntity>>>():
        emit(state.copyWith(allData: BaseState.error(result.errorMessage)));
    }
  }

  void onGovernorateChanged(String? newValue) {
    if (newValue == null) return;

    final cities = state.allData.data?[newValue] ?? [];

    emit(
      state.copyWith(
        selectedGov: newValue,
        filteredCities: BaseState.loaded(cities),
      ),
    );
  }
}
