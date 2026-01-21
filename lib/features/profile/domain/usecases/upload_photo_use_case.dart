import 'dart:io';

import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final ProfileRepo _profileRepo;
  const UploadPhotoUseCase(this._profileRepo);

  Future<Result<UploadPhotoResponse>> call({required File imageFile}) => _profileRepo.uploadPhoto(imageFile: imageFile);


}