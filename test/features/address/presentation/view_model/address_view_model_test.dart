import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/domain/entities/address_request_entity.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:flower_app/features/address/domain/repo/address_repository.dart';
import 'package:flower_app/features/address/presentation/view_model/address_state.dart';
import 'package:flower_app/features/address/presentation/view_model/address_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_view_model_test.mocks.dart';

@GenerateMocks([AddressRepository])
void main() {
  late AddressViewModel addressViewModel;
  late AddressRepository addressRepository;

  setUp(() {
    addressRepository = MockAddressRepository();
    addressViewModel = AddressViewModel(addressRepository);
  });

  final testCities = [
    CityEntity(nameAr: 'القاهرة', nameEn: 'Cairo', governorateId: '1'),
    CityEntity(nameAr: 'الجيزة', nameEn: 'Giza', governorateId: '2'),
  ];

  const testAddressEntity = AddressEntity(
    id: '1',
    street: 'Test Street',
    phone: '01234567890',
    city: 'Cairo',
    lat: '30.0444',
    long: '31.2357',
    username: 'Test User',
  );

  const testAddressRequestEntity = AddressRequestEntity(
    street: 'Test Street',
    phone: '01234567890',
    city: 'Cairo',
    lat: '30.0444',
    long: '31.2357',
    username: 'Test User',
  );

  final successCitiesResponse = Success(testCities);
  final failureCitiesResponse = Failure<List<CityEntity>>(
    'Failed to load cities',
  );

  final successAddressResponse = Success(
    const AddressResponseEntity(
      message: 'success',
      address: [testAddressEntity],
    ),
  );

  final failureAddressResponse = Failure<AddressResponseEntity>(
    'Failed to add address',
  );

  group('TEST AddressViewModel', () {
    group('loadInitialData', () {
      blocTest<AddressViewModel, AddressState>(
        'emits [loaded] when getCities is successful',
        build: () => addressViewModel,
        setUp: () {
          provideDummy<Result<List<CityEntity>>>(successCitiesResponse);
          when(
            addressRepository.getCities(),
          ).thenAnswer((_) async => successCitiesResponse);
        },
        act: (bloc) => bloc.loadInitialData('en'),
        expect: () {
          final Map<String, List<CityEntity>> governoratesMap = {
            'Cairo': [testCities[0]],
            'Giza': [testCities[1]],
          };
          return [
            AddressState(
              allData: BaseState.loaded(governoratesMap),
              filteredCities: BaseState.init(),
              loggedUserAddresses: BaseState.init(),
            ),
          ];
        },
      );

      blocTest<AddressViewModel, AddressState>(
        'emits [error] when getCities fails',
        build: () => addressViewModel,
        setUp: () {
          provideDummy<Result<List<CityEntity>>>(failureCitiesResponse);
          when(
            addressRepository.getCities(),
          ).thenAnswer((_) async => failureCitiesResponse);
        },
        act: (bloc) => bloc.loadInitialData('en'),
        expect: () {
          return [
            AddressState(
              allData: BaseState.error(failureCitiesResponse.errorMessage),
              filteredCities: BaseState.init(),
              loggedUserAddresses: BaseState.init(),
            ),
          ];
        },
      );
    });

    group('loadLocation', () {
      blocTest<AddressViewModel, AddressState>(
        'emits state with loaded location',
        build: () => addressViewModel,
        act: (bloc) => bloc.loadLocation(const LatLng(30.0444, 31.2357)),
        expect: () {
          return [
            AddressState(
              allData: BaseState.init(),
              filteredCities: BaseState.init(),
              loggedUserAddresses: BaseState.init(),
              location: BaseState.loaded(const LatLng(30.0444, 31.2357)),
            ),
          ];
        },
      );
    });

    group('onGovernorateChanged', () {
      blocTest<AddressViewModel, AddressState>(
        'emits state with filtered cities when governorate is selected',
        build: () => addressViewModel,
        seed: () => AddressState(
          allData: BaseState.loaded({
            'Cairo': [testCities[0]],
            'Giza': [testCities[1]],
          }),
          filteredCities: BaseState.init(),
          loggedUserAddresses: BaseState.init(),
        ),
        act: (bloc) => bloc.onGovernorateChanged('Cairo'),
        expect: () {
          return [
            AddressState(
              allData: BaseState.loaded({
                'Cairo': [testCities[0]],
                'Giza': [testCities[1]],
              }),
              selectedGov: 'Cairo',
              filteredCities: BaseState.loaded([testCities[0]]),
              loggedUserAddresses: BaseState.init(),
            ),
          ];
        },
      );
    });

    group('AddAddressEvent', () {
      blocTest<AddressViewModel, AddressState>(
        'emits [loading, loaded] when addAddress is successful',
        build: () => addressViewModel,
        setUp: () {
          provideDummy<Result<AddressResponseEntity>>(successAddressResponse);
          when(
            addressRepository.addAddress(testAddressRequestEntity),
          ).thenAnswer((_) async => successAddressResponse);
          when(
            addressRepository.getLoggedUserAddress(),
          ).thenAnswer((_) async => successAddressResponse);
        },
        act: (bloc) => bloc.doIntent(AddAddressEvent(testAddressRequestEntity)),
        expect: () {
          var state = AddressState(
            allData: BaseState.init(),
            filteredCities: BaseState.init(),
            loggedUserAddresses: BaseState.init(),
          );
          return [
            state.copyWith(allAddress: BaseState.loading()),
            state.copyWith(
              allAddress: BaseState.loaded(successAddressResponse.data.address),
            ),
            state.copyWith(
              allAddress: BaseState.loaded(successAddressResponse.data.address),
              loggedUserAddresses: BaseState.loading(),
            ),
            state.copyWith(
              allAddress: BaseState.loaded(successAddressResponse.data.address),
              loggedUserAddresses: BaseState.loaded(
                successAddressResponse.data.address,
              ),
            ),
          ];
        },
      );

      blocTest<AddressViewModel, AddressState>(
        'emits [loading, error] when addAddress fails',
        build: () => addressViewModel,
        setUp: () {
          provideDummy<Result<AddressResponseEntity>>(failureAddressResponse);
          when(
            addressRepository.addAddress(testAddressRequestEntity),
          ).thenAnswer((_) async => failureAddressResponse);
        },
        act: (bloc) => bloc.doIntent(AddAddressEvent(testAddressRequestEntity)),
        expect: () {
          var state = AddressState(
            allData: BaseState.init(),
            filteredCities: BaseState.init(),
            loggedUserAddresses: BaseState.init(),
          );
          return [
            state.copyWith(allAddress: BaseState.loading()),
            state.copyWith(
              allAddress: BaseState.error(failureAddressResponse.errorMessage),
            ),
          ];
        },
      );
    });

    group('UpdateAddressEvent', () {
      blocTest<AddressViewModel, AddressState>(
        'emits [loading, loaded] when updateAddress is successful',
        build: () => addressViewModel,
        setUp: () {
          provideDummy<Result<AddressResponseEntity>>(successAddressResponse);
          when(
            addressRepository.updateAddress(testAddressRequestEntity, '1'),
          ).thenAnswer((_) async => successAddressResponse);
        },
        act: (bloc) =>
            bloc.doIntent(UpdateAddressEvent(testAddressRequestEntity, '1')),
        expect: () {
          var state = AddressState(
            allData: BaseState.init(),
            filteredCities: BaseState.init(),
            loggedUserAddresses: BaseState.init(),
          );
          return [
            state.copyWith(allAddress: BaseState.loading()),
            state.copyWith(
              allAddress: BaseState.loaded(successAddressResponse.data.address),
            ),
          ];
        },
      );

      blocTest<AddressViewModel, AddressState>(
        'emits [loading, error] when updateAddress fails',
        build: () => addressViewModel,
        setUp: () {
          provideDummy<Result<AddressResponseEntity>>(failureAddressResponse);
          when(
            addressRepository.updateAddress(testAddressRequestEntity, '1'),
          ).thenAnswer((_) async => failureAddressResponse);
        },
        act: (bloc) =>
            bloc.doIntent(UpdateAddressEvent(testAddressRequestEntity, '1')),
        expect: () {
          var state = AddressState(
            allData: BaseState.init(),
            filteredCities: BaseState.init(),
            loggedUserAddresses: BaseState.init(),
          );
          return [
            state.copyWith(allAddress: BaseState.loading()),
            state.copyWith(
              allAddress: BaseState.error(failureAddressResponse.errorMessage),
            ),
          ];
        },
      );
    });

    group('DeleteAddressEvent', () {
      blocTest<AddressViewModel, AddressState>(
        'emits [loading, loaded] when deleteAddress is successful',
        build: () => addressViewModel,
        seed: () => AddressState(
          allData: BaseState.init(),
          filteredCities: BaseState.init(),
          loggedUserAddresses: BaseState.loaded([testAddressEntity]),
        ),
        setUp: () {
          provideDummy<Result<AddressResponseEntity>>(successAddressResponse);
          when(
            addressRepository.deleteAddress('1'),
          ).thenAnswer((_) async => successAddressResponse);
        },
        act: (bloc) => bloc.doIntent(DeleteAddressEvent('1')),
        expect: () {
          var state = AddressState(
            allData: BaseState.init(),
            filteredCities: BaseState.init(),
            loggedUserAddresses: BaseState.loaded([testAddressEntity]),
          );
          return [
            state.copyWith(loggedUserAddresses: BaseState.loading()),
            state.copyWith(loggedUserAddresses: BaseState.loaded([])),
          ];
        },
      );

      blocTest<AddressViewModel, AddressState>(
        'emits [loading, error] when deleteAddress fails',
        build: () => addressViewModel,
        seed: () => AddressState(
          allData: BaseState.init(),
          filteredCities: BaseState.init(),
          loggedUserAddresses: BaseState.loaded([testAddressEntity]),
        ),
        setUp: () {
          provideDummy<Result<AddressResponseEntity>>(failureAddressResponse);
          when(
            addressRepository.deleteAddress('1'),
          ).thenAnswer((_) async => failureAddressResponse);
        },
        act: (bloc) => bloc.doIntent(DeleteAddressEvent('1')),
        expect: () {
          var state = AddressState(
            allData: BaseState.init(),
            filteredCities: BaseState.init(),
            loggedUserAddresses: BaseState.loaded([testAddressEntity]),
          );
          return [
            state.copyWith(loggedUserAddresses: BaseState.loading()),
            state.copyWith(
              loggedUserAddresses: BaseState.error(
                failureAddressResponse.errorMessage,
              ),
            ),
          ];
        },
      );
    });

    group('GetLoggedUserAddress', () {
      blocTest<AddressViewModel, AddressState>(
        'emits [loading, loaded] when getLoggedUserAddress is successful',
        build: () => addressViewModel,
        setUp: () {
          provideDummy<Result<AddressResponseEntity>>(successAddressResponse);
          when(
            addressRepository.getLoggedUserAddress(),
          ).thenAnswer((_) async => successAddressResponse);
        },
        act: (bloc) => bloc.doIntent(GetLoggedUserAddress()),
        expect: () {
          var state = AddressState(
            allData: BaseState.init(),
            filteredCities: BaseState.init(),
            loggedUserAddresses: BaseState.init(),
          );
          return [
            state.copyWith(loggedUserAddresses: BaseState.loading()),
            state.copyWith(
              loggedUserAddresses: BaseState.loaded(
                successAddressResponse.data.address,
              ),
            ),
          ];
        },
      );

      blocTest<AddressViewModel, AddressState>(
        'emits [loading, error] when getLoggedUserAddress fails',
        build: () => addressViewModel,
        setUp: () {
          provideDummy<Result<AddressResponseEntity>>(failureAddressResponse);
          when(
            addressRepository.getLoggedUserAddress(),
          ).thenAnswer((_) async => failureAddressResponse);
        },
        act: (bloc) => bloc.doIntent(GetLoggedUserAddress()),
        expect: () {
          var state = AddressState(
            allData: BaseState.init(),
            filteredCities: BaseState.init(),
            loggedUserAddresses: BaseState.init(),
          );
          return [
            state.copyWith(loggedUserAddresses: BaseState.loading()),
            state.copyWith(
              loggedUserAddresses: BaseState.error(
                failureAddressResponse.errorMessage,
              ),
            ),
          ];
        },
      );
    });
  });
}
