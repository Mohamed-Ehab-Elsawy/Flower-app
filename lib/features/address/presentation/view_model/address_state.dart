import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/address/domain/entities/address_request_entity.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressState extends Equatable {
  final BaseState<Map<String, List<CityEntity>>>? allData;
  final String? selectedGov;
  final BaseState<List<CityEntity?>>? filteredCities;
  final BaseState<List<AddressEntity?>>? allAddress;
  final BaseState<List<AddressEntity?>>? loggedUserAddresses;
  final BaseState<LatLng>? location;

  const AddressState({
    this.location,
    this.allAddress,
    this.allData,
    this.selectedGov,
    this.filteredCities,
    this.loggedUserAddresses,
  });

  AddressState copyWith({
    BaseState<Map<String, List<CityEntity>>>? allData,
    String? selectedGov,
    BaseState<List<CityEntity>>? filteredCities,
    BaseState<List<AddressEntity?>>? allAddress,
    BaseState<List<AddressEntity?>>? loggedUserAddresses,
    BaseState<LatLng>? location,
  }) {
    return AddressState(
      allData: allData ?? this.allData,
      selectedGov: selectedGov ?? this.selectedGov,
      filteredCities: filteredCities ?? this.filteredCities,
      allAddress: allAddress ?? this.allAddress,
      location: location ?? this.location,
      loggedUserAddresses: loggedUserAddresses ?? this.loggedUserAddresses,
    );
  }

  @override
  List<Object?> get props => [
    allData,
    selectedGov,
    filteredCities,
    allAddress,
    location,
    loggedUserAddresses,
  ];
}

sealed class UIAddressEvent {}

class DeleteAddressEvent extends UIAddressEvent {
  final String id;
  DeleteAddressEvent(this.id);
}

class UpdateAddressEvent extends UIAddressEvent {
  final AddressRequestEntity entity;
  final String id;
  UpdateAddressEvent(this.entity, this.id);
}

class AddAddressEvent extends UIAddressEvent {
  final AddressRequestEntity entity;
  AddAddressEvent(this.entity);
}

class GetLoggedUserAddress extends UIAddressEvent {}

class NavigatorToAddressView extends UIAddressEvent {}
class PopToSavedAddressView extends UIAddressEvent {}