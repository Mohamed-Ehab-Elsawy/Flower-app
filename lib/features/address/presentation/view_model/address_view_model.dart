import 'dart:async';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/constants/constants.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/domain/entities/address_request_entity.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:flower_app/features/address/domain/repo/address_repository.dart';
import 'package:flower_app/features/address/presentation/view_model/address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddressViewModel extends Cubit<AddressState> {
  final AddressRepository _addressRepository;

  final _uiEventsController = StreamController<UIAddressEvent>.broadcast();
  Stream<UIAddressEvent> get uiEventsStream => _uiEventsController.stream;

  AddressViewModel(this._addressRepository)
    : super(
        AddressState(
          allData: BaseState.init(),
          filteredCities: BaseState.init(),
          loggedUserAddresses: BaseState.init(),
        ),
      );

  void loadLocation(LatLng location) {
    emit(state.copyWith(location: BaseState.loaded(location)));
  }

  void doIntent(UIAddressEvent intent) {
    switch (intent) {
      case DeleteAddressEvent():
        _uiEventsController.add(DeleteAddressEvent(intent.id));
        _deleteAddress(intent.id);
      case AddAddressEvent():
        _uiEventsController.add(AddAddressEvent(intent.entity));
        _addAddress(intent.entity);
      case UpdateAddressEvent():
        _uiEventsController.add(UpdateAddressEvent(intent.entity, intent.id));
        _updateAddress(intent.entity, intent.id);
      case GetLoggedUserAddress():
        _getLoggedUserAddress();
      case NavigatorToAddressView():
        _uiEventsController.add(NavigatorToAddressView());
      case PopToSavedAddressView():
        _uiEventsController.add(PopToSavedAddressView());
    }
  }

  Future<void> loadInitialData(String lang) async {
    final result = await _addressRepository.getCities();
    switch (result) {
      case Success<List<CityEntity>>():
        final Map<String, List<CityEntity>> governoratesMap = {};

        for (var city in result.data) {
          final govData = egyptGovernorates[city.governorateId];

          final String govNameKey = lang == 'ar'
              ? (govData?['ar'] ?? city.governorateId)
              : (govData?['en'] ?? city.governorateId);

          if (!governoratesMap.containsKey(govNameKey)) {
            governoratesMap[govNameKey] = [];
          }
          governoratesMap[govNameKey]!.add(city);
        }
        emit(state.copyWith(allData: BaseState.loaded(governoratesMap)));

      case Failure<List<CityEntity>>():
        emit(state.copyWith(allData: BaseState.error(result.errorMessage)));
    }
  }

  void onGovernorateChanged(String? newValue) {
    if (newValue == null) return;

    final cities = state.allData?.data?[newValue] ?? [];

    emit(
      state.copyWith(
        selectedGov: newValue,
        filteredCities: BaseState.loaded(cities),
      ),
    );
  }

  void _addAddress(AddressRequestEntity entity) async {
    emit(state.copyWith(allAddress: BaseState.loading()));

    final result = await _addressRepository.addAddress(entity);

    switch (result) {
      case Success<AddressResponseEntity>():
        emit(state.copyWith(allAddress: BaseState.loaded(result.data.address)));

        _getLoggedUserAddress();

      case Failure<AddressResponseEntity>():
        emit(state.copyWith(allAddress: BaseState.error(result.errorMessage)));
    }
  }

  void _deleteAddress(String id) async {
    final currentAddresses = state.loggedUserAddresses?.data ?? [];

    emit(state.copyWith(loggedUserAddresses: BaseState.loading()));

    final result = await _addressRepository.deleteAddress(id);

    switch (result) {
      case Success<AddressResponseEntity>():
        final updatedList = currentAddresses
            .where((address) => address?.id != id)
            .toList();

        emit(
          state.copyWith(loggedUserAddresses: BaseState.loaded(updatedList)),
        );

      case Failure<AddressResponseEntity>():
        emit(
          state.copyWith(
            loggedUserAddresses: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  void _updateAddress(AddressRequestEntity entity, String id) async {
    emit(state.copyWith(allAddress: BaseState.loading()));
    final result = await _addressRepository.updateAddress(entity, id);
    switch (result) {
      case Success<AddressResponseEntity>():
        emit(state.copyWith(allAddress: BaseState.loaded(result.data.address)));
      case Failure<AddressResponseEntity>():
        emit(state.copyWith(allAddress: BaseState.error(result.errorMessage)));
    }
  }

  void _getLoggedUserAddress() async {
    emit(state.copyWith(loggedUserAddresses: BaseState.loading()));
    final result = await _addressRepository.getLoggedUserAddress();
    switch (result) {
      case Success<AddressResponseEntity>():
        emit(
          state.copyWith(
            loggedUserAddresses: BaseState.loaded(result.data.address),
          ),
        );

      case Failure<AddressResponseEntity>():
        emit(
          state.copyWith(
            loggedUserAddresses: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
