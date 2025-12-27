import 'package:flower_app/features/categories/domain/repositories/category_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryRepo)
class CategoryRepoImpl implements CategoryRepo {}
