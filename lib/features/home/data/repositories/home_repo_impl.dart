import 'package:flower_app/features/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {}
