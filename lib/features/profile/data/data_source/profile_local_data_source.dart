import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/data/models/about_us_dto.dart';

abstract interface class ProfileLocalDataSource {
  Future<Result<AboutUsDto>> getAboutUs();
}
