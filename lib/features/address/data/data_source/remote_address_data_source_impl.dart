import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/data/data_source/remote_data_source.dart';
import 'package:flower_app/features/address/data/models/address_request_dto.dart';
import 'package:flower_app/features/address/data/models/address_response_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiClient _apiClient;

  RemoteDataSourceImpl(this._apiClient);
  @override
  Future<Result<AddressResponseDto>> addAddress(
    AddressRequestDto addressDetails,
  ) {
    return executeApi(() => _apiClient.addAddress(addressDetails));
  }

  @override
  Future<Result<AddressResponseDto>> deleteAddress(String id) {
    return executeApi(() => _apiClient.deleteAddress(id));
  }

  @override
  Future<Result<AddressResponseDto>> getLoggedUserAddress() {
    return executeApi(() => _apiClient.getLoggedUserAddress());
  }

  @override
  Future<Result<AddressResponseDto>> updateAddress(
    AddressRequestDto addressDetails,
    String id,
  ) {
    return executeApi(() => _apiClient.updateAddress(addressDetails, id));
  }
}
