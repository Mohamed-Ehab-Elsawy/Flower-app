import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/get_user_data_response.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRepoImpl(this._profileRemoteDataSource);


  @override
  Future<Result<UserEntity>> getProfileData() async {
    var response = await _profileRemoteDataSource.getProfileData();
    switch(response) {
      case Success<GetUserDataResponse>():
        {
          UserDto userDto = response.data.user ?? UserDto();
          UserEntity userEntity = userDto.toEntity();
          return Success(userEntity);
        }
      case Failure<GetUserDataResponse>():
      {
        return Failure(response.errorMessage);
      }
    }
  }

  @override
  Future<Result<UserEntity>> editProfile ({required EditProfileRequest editProfileRequest}) async {
    var response = await _profileRemoteDataSource.editProfile(editProfileRequest: editProfileRequest);
    switch(response) {
      case Success<GetUserDataResponse>():
        {
          UserDto userDto = response.data.user ?? UserDto();
          UserEntity userEntity = userDto.toEntity();
          return Success(userEntity);
        }
      case Failure<GetUserDataResponse>():
        {
          return Failure(response.errorMessage);
        }
    }
  }

  @override
  Future<Result<UploadPhotoResponse>> uploadPhoto({required File imageFile}) async {
    final multipart = await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last);
    final response = await _profileRemoteDataSource.uploadPhoto(photo: multipart);
    switch (response) {
      case Success<UploadPhotoResponse>():
       return Success(response.data);
      case Failure<UploadPhotoResponse>():
        return Failure(response.errorMessage);
    }
  }
}
