import 'package:flower_app/features/categories/data/datasources/category_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryDataSource)
class CategoryDataSourceImpl implements CategoryDataSource {}
