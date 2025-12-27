import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {}
