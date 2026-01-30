import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/domain/entity/about_us_entity.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutUsUseCase {
  final ProfileRepo _profileRepo;
  const AboutUsUseCase(this._profileRepo);
  Future<Result<AboutUsEntity>> invoke() => _profileRepo.getAboutUs();
}
