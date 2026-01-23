import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileDataUseCase {
  final ProfileRepo _profileRepo;
  const GetProfileDataUseCase(this._profileRepo);
  Future<Result<UserEntity>> call() => _profileRepo.getProfileData();
}
