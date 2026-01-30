import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/data/data_source/address_data_source.dart';
import 'package:flower_app/features/address/data/data_source/remote_data_source.dart';
import 'package:flower_app/features/address/data/models/address_response_dto.dart';
import 'package:flower_app/features/address/data/models/city_model.dart';
import 'package:flower_app/features/address/data/repo/address_repository_impl.dart';
import 'package:flower_app/features/address/domain/entities/address_request_entity.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:flower_app/features/address/domain/repo/address_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_repository_impl_test.mocks.dart';

@GenerateMocks([AddressDataSource, RemoteDataSource])
void main() {
  late MockAddressDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late AddressRepository addressRepository;

  setUp(() {
    mockLocalDataSource = MockAddressDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    addressRepository = AddressRepositoryImpl(
      mockLocalDataSource,
      mockRemoteDataSource,
    );
    provideDummy<Result<List<CityDto>>>(Success(const []));
    provideDummy<Result<AddressResponseDto>>(
      Success(const AddressResponseDto()),
    );
  });

  group("Test Address Repository Impl with Success", () {
    test("Test getCities", () async {
      const tCityModel = CityDto(
        id: "1",
        governorateId: "1",
        cityNameAr: "Cairo",
        cityNameEn: "Cairo",
      );
      final tCityEntity = CityEntity(
        nameAr: "Cairo",
        nameEn: "Cairo",
        governorateId: "1",
      );
      final tSuccessResponse = Success<List<CityDto>>(const [tCityModel]);

      when(
        mockLocalDataSource.getCities(),
      ).thenAnswer((_) async => tSuccessResponse);

      final result =
          await addressRepository.getCities() as Success<List<CityEntity>>;

      expect(result, isA<Result<List<CityEntity>>>());
      expect(result.data.first.nameEn, tCityEntity.nameEn);
      expect(result.data.first.nameAr, tCityEntity.nameAr);
      expect(result.data.first.governorateId, tCityEntity.governorateId);
    });

    test("Test addAddress", () async {
      const tAddressRequestEntity = AddressRequestEntity(
        street: "street",
        phone: "phone",
        city: "city",
        username: "username",
        lat: "lat",
        long: "long",
      );
      const tAddressResponseDto = AddressResponseDto(message: "success");
      const tAddressResponseEntity = AddressResponseEntity(
        message: "success",
        address: [],
      );
      final tSuccessResponse = Success<AddressResponseDto>(tAddressResponseDto);

      when(
        mockRemoteDataSource.addAddress(any),
      ).thenAnswer((_) async => tSuccessResponse);

      final result =
          await addressRepository.addAddress(tAddressRequestEntity)
              as Success<AddressResponseEntity>;

      expect(result, isA<Result<AddressResponseEntity>>());
      expect(result.data, tAddressResponseEntity);
    });

    test("Test deleteAddress", () async {
      const tId = "1";
      const tAddressResponseDto = AddressResponseDto(message: "success");
      const tAddressResponseEntity = AddressResponseEntity(
        message: "success",
        address: [],
      );
      final tSuccessResponse = Success<AddressResponseDto>(tAddressResponseDto);

      when(
        mockRemoteDataSource.deleteAddress(tId),
      ).thenAnswer((_) async => tSuccessResponse);

      final result =
          await addressRepository.deleteAddress(tId)
              as Success<AddressResponseEntity>;

      expect(result, isA<Result<AddressResponseEntity>>());
      expect(result.data, tAddressResponseEntity);
    });

    test("Test getLoggedUserAddress", () async {
      const tAddressResponseDto = AddressResponseDto(message: "success");
      const tAddressResponseEntity = AddressResponseEntity(
        message: "success",
        address: [],
      );
      final tSuccessResponse = Success<AddressResponseDto>(tAddressResponseDto);

      when(
        mockRemoteDataSource.getLoggedUserAddress(),
      ).thenAnswer((_) async => tSuccessResponse);

      final result =
          await addressRepository.getLoggedUserAddress()
              as Success<AddressResponseEntity>;

      expect(result, isA<Result<AddressResponseEntity>>());
      expect(result.data, tAddressResponseEntity);
    });

    test("Test updateAddress", () async {
      const tAddressRequestEntity = AddressRequestEntity(
        street: "street",
        phone: "phone",
        city: "city",
        username: "username",
        lat: "lat",
        long: "long",
      );
      const tId = "1";
      const tAddressResponseDto = AddressResponseDto(message: "success");
      const tAddressResponseEntity = AddressResponseEntity(
        message: "success",
        address: [],
      );
      final tSuccessResponse = Success<AddressResponseDto>(tAddressResponseDto);

      when(
        mockRemoteDataSource.updateAddress(any, tId),
      ).thenAnswer((_) async => tSuccessResponse);

      final result =
          await addressRepository.updateAddress(tAddressRequestEntity, tId)
              as Success<AddressResponseEntity>;

      expect(result, isA<Result<AddressResponseEntity>>());
      expect(result.data, tAddressResponseEntity);
    });
  });

  group("Test Address Repository Impl with Failure", () {
    late String errorMessage;

    setUp(() {
      errorMessage = "unexpected error";
    });

    test("Test getCities should return failure result", () async {
      final failureResult = Failure<List<CityDto>>(errorMessage);

      when(
        mockLocalDataSource.getCities(),
      ).thenAnswer((_) async => failureResult);

      final result =
          await addressRepository.getCities() as Failure<List<CityEntity>>;

      expect(result, isA<Result<List<CityEntity>>>());
      expect(result.errorMessage, errorMessage);
    });

    test("Test addAddress should return failure result", () async {
      const tAddressRequestEntity = AddressRequestEntity(
        street: "street",
        phone: "phone",
        city: "city",
        username: "username",
        lat: "lat",
        long: "long",
      );
      final failureResult = Failure<AddressResponseDto>(errorMessage);

      when(
        mockRemoteDataSource.addAddress(any),
      ).thenAnswer((_) async => failureResult);

      final result =
          await addressRepository.addAddress(tAddressRequestEntity)
              as Failure<AddressResponseEntity>;

      expect(result, isA<Result<AddressResponseEntity>>());
      expect(result.errorMessage, errorMessage);
    });

    test("Test deleteAddress should return failure result", () async {
      const tId = "1";
      final failureResult = Failure<AddressResponseDto>(errorMessage);

      when(
        mockRemoteDataSource.deleteAddress(tId),
      ).thenAnswer((_) async => failureResult);

      final result =
          await addressRepository.deleteAddress(tId)
              as Failure<AddressResponseEntity>;

      expect(result, isA<Result<AddressResponseEntity>>());
      expect(result.errorMessage, errorMessage);
    });

    test("Test getLoggedUserAddress should return failure result", () async {
      final failureResult = Failure<AddressResponseDto>(errorMessage);

      when(
        mockRemoteDataSource.getLoggedUserAddress(),
      ).thenAnswer((_) async => failureResult);

      final result =
          await addressRepository.getLoggedUserAddress()
              as Failure<AddressResponseEntity>;

      expect(result, isA<Result<AddressResponseEntity>>());
      expect(result.errorMessage, errorMessage);
    });

    test("Test updateAddress should return failure result", () async {
      const tAddressRequestEntity = AddressRequestEntity(
        street: "street",
        phone: "phone",
        city: "city",
        username: "username",
        lat: "lat",
        long: "long",
      );
      const tId = "1";
      final failureResult = Failure<AddressResponseDto>(errorMessage);

      when(
        mockRemoteDataSource.updateAddress(any, tId),
      ).thenAnswer((_) async => failureResult);

      final result =
          await addressRepository.updateAddress(tAddressRequestEntity, tId)
              as Failure<AddressResponseEntity>;

      expect(result, isA<Result<AddressResponseEntity>>());
      expect(result.errorMessage, errorMessage);
    });
  });
}
