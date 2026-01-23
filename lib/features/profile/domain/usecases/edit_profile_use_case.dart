import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepo _profileRepo;
  const EditProfileUseCase(this._profileRepo);

  Future<Result<UserEntity>> call({
    required EditProfileRequest editProfileRequest,
  }) => _profileRepo.editProfile(editProfileRequest: editProfileRequest);
}
