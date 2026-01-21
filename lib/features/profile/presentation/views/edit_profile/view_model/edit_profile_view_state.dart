import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';

class EditProfileViewState extends Equatable{
  final BaseState<UserEntity> getProfileDateStates;
  final BaseState<UserEntity> editProfileStates;
  final BaseState<UploadPhotoResponse> uploadPhotoStates;
  final File? localImage;        // الصورة المؤقتة (preview)

  const EditProfileViewState({
    required this.getProfileDateStates,
    required this.editProfileStates,
    required this.uploadPhotoStates,
    this.localImage,
  });

  factory EditProfileViewState.initial() => EditProfileViewState(
    getProfileDateStates: BaseState.init(),
    editProfileStates: BaseState.init(),
    uploadPhotoStates: BaseState.init(),
    localImage: null,
  );

  EditProfileViewState copyWith({
    BaseState<UserEntity>? getProfileDateStates,
    BaseState<UserEntity>? editProfileStates,
    BaseState<UploadPhotoResponse>? uploadPhotoStates,
    File? localImage,
  }) {
    return EditProfileViewState(
      getProfileDateStates: getProfileDateStates ?? this.getProfileDateStates,
      editProfileStates: editProfileStates ?? this.editProfileStates,
      uploadPhotoStates: uploadPhotoStates ?? this.uploadPhotoStates,
      localImage: localImage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [getProfileDateStates,editProfileStates,uploadPhotoStates,localImage];
}
