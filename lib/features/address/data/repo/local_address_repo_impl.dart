import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/data/data_source/address_data_source.dart';
import 'package:flower_app/features/address/data/mapper/city_mapper.dart';
import 'package:flower_app/features/address/data/models/city_model.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:flower_app/features/address/domain/repo/address_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AddressRepo)
class LocalAddressRepoImpl implements AddressRepo {
  final AddressDataSource _addressDataSource;

  LocalAddressRepoImpl(this._addressDataSource);

  @override
  Future<Result<List<CityEntity>>> getCities() async {
    final response = await _addressDataSource.getCities();
    switch (response) {
      case Success<List<CityModel>>():
        return Success(response.data.map((e) => e.toEntity()).toList());
      case Failure<List<CityModel>>():
        return Failure(response.errorMessage);
    }
  }
}
