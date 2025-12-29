import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:flower_app/features/home/domain/mapper/best_seller_response_mapper.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeDataSource _homeDataSource;

  HomeRepoImpl(this._homeDataSource);

  @override
  Future<Result<BestSellerEntity>> getBestSeller() async {
    final response = await _homeDataSource.getBestSeller();
    switch (response) {
      case Success<BestSellerResponse>():
        var result = response.data.toModel();
        return Success(result);

      case Failure<BestSellerResponse>():
        return Failure(response.errorMessage);
    }
  }
}
