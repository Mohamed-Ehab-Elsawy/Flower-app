import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/data/data_source/address_data_source.dart';
import 'package:flower_app/features/address/data/data_source/remote_data_source.dart';
import 'package:flower_app/features/address/data/mapper/address_mapper.dart';
import 'package:flower_app/features/address/data/mapper/city_mapper.dart';
import 'package:flower_app/features/address/data/models/address_response_dto.dart';
import 'package:flower_app/features/address/data/models/city_model.dart';
import 'package:flower_app/features/address/domain/entities/address_request_entity.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:flower_app/features/address/domain/repo/address_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AddressRepository)
class AddressRepositoryImpl implements AddressRepository {
  final AddressDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  AddressRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Result<List<CityEntity>>> getCities() async {
    final response = await _localDataSource.getCities();
    switch (response) {
      case Success<List<CityModel>>():
        return Success(response.data.map((e) => e.toEntity()).toList());
      case Failure<List<CityModel>>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<AddressResponseEntity>> addAddress(
    AddressRequestEntity entity,
  ) async {
    final result = await _remoteDataSource.addAddress(entity.toDto());
    switch (result) {
      case Success<AddressResponseDto>():
        return Success(result.data.toEntity());
      case Failure<AddressResponseDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<AddressResponseEntity>> deleteAddress(String id) async {
    final result = await _remoteDataSource.deleteAddress(id);
    switch (result) {
      case Success<AddressResponseDto>():
        return Success(result.data.toEntity());
      case Failure<AddressResponseDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<AddressResponseEntity>> getLoggedUserAddress() async {
    final result = await _remoteDataSource.getLoggedUserAddress();
    switch (result) {
      case Success<AddressResponseDto>():
        return Success(result.data.toEntity());
      case Failure<AddressResponseDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<AddressResponseEntity>> updateAddress(
    AddressRequestEntity addressEntity,
    String id,
  ) async {
    final result = await _remoteDataSource.updateAddress(
      addressEntity.toDto(),
      id,
    );
    switch (result) {
      case Success<AddressResponseDto>():
        return Success(result.data.toEntity());
      case Failure<AddressResponseDto>():
        return Failure(result.errorMessage);
    }
  }
}
