import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:flower_app/features/home/mapper/home_response_mapper.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeDataSource _homeDataSource;

  const HomeRepoImpl(this._homeDataSource);
  @override
  Future<Result<HomeResponseEntity>> fetchHomeData() async {
    var response = await _homeDataSource.fetchHomeData();
    switch (response) {
      case Success<HomeResponseDto>():
        var result = response.data.toEntity();
        return Success(result);
      case Failure<HomeResponseDto>():
        return Failure(response.errorMessage);
    }
  }
}
