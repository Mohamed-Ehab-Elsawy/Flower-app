import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:image_picker/image_picker.dart';

sealed class Intent {}

final class GetProfileData extends Intent {}

final class EditProfile extends Intent {
  final EditProfileRequest editProfileRequest;
  EditProfile(this.editProfileRequest);
}
final class SelectLocalPhoto extends Intent {
  final File file;
  SelectLocalPhoto(this.file);
}

class UploadPhoto extends Intent {
  final File imageFile;
  UploadPhoto(this.imageFile);
}

final class PickImageFromGallery extends Intent {}

final class PickImageFromCamera extends Intent {}




sealed class EditProfileUIEvents {}

final class NavigateToResetPasswordEvent extends EditProfileUIEvents {}
final class PopScreenEvent extends EditProfileUIEvents {}


final class PopWithImageSource extends EditProfileUIEvents {
  final ImageSource source;
  PopWithImageSource(this.source);
}

final class EditProfileViewShowToast extends EditProfileUIEvents with EquatableMixin {
  final String message;
  final bool isError;

  EditProfileViewShowToast({
    this.message = "Something went wrong",
    this.isError = false,
  });
  @override
  List<Object?> get props => [message, isError];
}

final class UploadPhotoViewShowToast extends EditProfileUIEvents
    with EquatableMixin {
  final String message;
  final bool isError;

  UploadPhotoViewShowToast({
    this.message = "Something went wrong",
    this.isError = false,
  });
  @override
  List<Object?> get props => [message, isError];
}
