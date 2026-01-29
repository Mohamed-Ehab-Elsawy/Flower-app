import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/failures.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/data/data_source/remote_address_data_source_impl.dart';
import 'package:flower_app/features/address/data/data_source/remote_data_source.dart';
import 'package:flower_app/features/address/data/models/address_request_dto.dart';
import 'package:flower_app/features/address/data/models/address_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_address_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late ApiClient mockApiClient;
  late RemoteDataSource remoteDataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    remoteDataSource = RemoteDataSourceImpl(mockApiClient);
  });

  group("Test Remote Address DataSource Impl with Success", () {
    test("Test addAddress", () async {
      const tAddressRequestDto = AddressRequestDto(
        street: "street",
        phone: "phone",
        city: "city",
        username: "username",
        lat: "lat",
        long: "long",
      );
      const tAddressResponseDto = AddressResponseDto(message: "success");

      when(
        mockApiClient.addAddress(tAddressRequestDto),
      ).thenAnswer((_) async => tAddressResponseDto);

      final result =
          await remoteDataSource.addAddress(tAddressRequestDto)
              as Success<AddressResponseDto>;

      expect(result, isA<Result<AddressResponseDto>>());
      expect(result.data, tAddressResponseDto);
    });

    test("Test deleteAddress", () async {
      const tAddressResponseDto = AddressResponseDto(message: "success");
      const tId = "1";

      when(
        mockApiClient.deleteAddress(tId),
      ).thenAnswer((_) async => tAddressResponseDto);

      final result =
          await remoteDataSource.deleteAddress(tId)
              as Success<AddressResponseDto>;

      expect(result, isA<Result<AddressResponseDto>>());
      expect(result.data, tAddressResponseDto);
    });

    test("Test getLoggedUserAddress", () async {
      const tAddressResponseDto = AddressResponseDto(message: "success");

      when(
        mockApiClient.getLoggedUserAddress(),
      ).thenAnswer((_) async => tAddressResponseDto);

      final result =
          await remoteDataSource.getLoggedUserAddress()
              as Success<AddressResponseDto>;

      expect(result, isA<Result<AddressResponseDto>>());
      expect(result.data, tAddressResponseDto);
    });

    test("Test updateAddress", () async {
      const tAddressRequestDto = AddressRequestDto(
        street: "street",
        phone: "phone",
        city: "city",
        username: "username",
        lat: "lat",
        long: "long",
      );
      const tAddressResponseDto = AddressResponseDto(message: "success");
      const tId = "1";

      when(
        mockApiClient.updateAddress(tAddressRequestDto, tId),
      ).thenAnswer((_) async => tAddressResponseDto);

      final result =
          await remoteDataSource.updateAddress(tAddressRequestDto, tId)
              as Success<AddressResponseDto>;

      expect(result, isA<Result<AddressResponseDto>>());
      expect(result.data, tAddressResponseDto);
    });
  });

  group("Test Remote Address DataSource Impl with Failure", () {
    late AppFailure tAppFailure;
    late String errorMessage;

    setUp(() {
      errorMessage = "unexpected error";
      tAppFailure = UnexpectedFailure(errorMessage);
    });

    test("Test addAddress should throw failure result", () async {
      const tAddressRequestDto = AddressRequestDto(
        street: "street",
        phone: "phone",
        city: "city",
        username: "username",
        lat: "lat",
        long: "long",
      );

      when(mockApiClient.addAddress(tAddressRequestDto)).thenThrow(tAppFailure);

      final result =
          await remoteDataSource.addAddress(tAddressRequestDto)
              as Failure<AddressResponseDto>;

      expect(result, isA<Result<AddressResponseDto>>());
      expect(result.errorMessage, tAppFailure.toString());
    });

    test("Test deleteAddress should throw failure result", () async {
      const tId = "1";

      when(mockApiClient.deleteAddress(tId)).thenThrow(tAppFailure);

      final result =
          await remoteDataSource.deleteAddress(tId)
              as Failure<AddressResponseDto>;

      expect(result, isA<Result<AddressResponseDto>>());
      expect(result.errorMessage, tAppFailure.toString());
    });

    test("Test getLoggedUserAddress should throw failure result", () async {
      when(mockApiClient.getLoggedUserAddress()).thenThrow(tAppFailure);

      final result =
          await remoteDataSource.getLoggedUserAddress()
              as Failure<AddressResponseDto>;

      expect(result, isA<Result<AddressResponseDto>>());
      expect(result.errorMessage, tAppFailure.toString());
    });

    test("Test updateAddress should throw failure result", () async {
      const tAddressRequestDto = AddressRequestDto(
        street: "street",
        phone: "phone",
        city: "city",
        username: "username",
        lat: "lat",
        long: "long",
      );
      const tId = "1";

      when(
        mockApiClient.updateAddress(tAddressRequestDto, tId),
      ).thenThrow(tAppFailure);

      final result =
          await remoteDataSource.updateAddress(tAddressRequestDto, tId)
              as Failure<AddressResponseDto>;

      expect(result, isA<Result<AddressResponseDto>>());
      expect(result.errorMessage, tAppFailure.toString());
    });
  });
}
