import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';

class AddressState extends Equatable {
  final BaseState<Map<String, List<CityEntity>>> allData;
  final String? selectedGov;
  final BaseState<List<CityEntity>>? filteredCities;

  const AddressState({
    required this.allData,
    this.selectedGov,
    this.filteredCities,
  });

  AddressState copyWith({
    BaseState<Map<String, List<CityEntity>>>? allData,
    String? selectedGov,
    BaseState<List<CityEntity>>? filteredCities,
  }) {
    return AddressState(
      allData: allData ?? this.allData,
      selectedGov: selectedGov ?? this.selectedGov,
      filteredCities: filteredCities ?? this.filteredCities,
    );
  }

  @override
  List<Object?> get props => [allData, selectedGov, filteredCities];
}
