import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchHomeDataUsecase {
  final HomeRepo _homeRepo;
  const FetchHomeDataUsecase(this._homeRepo);
  Future<Result<HomeResponseEntity>> call() => _homeRepo.fetchHomeData();
}
