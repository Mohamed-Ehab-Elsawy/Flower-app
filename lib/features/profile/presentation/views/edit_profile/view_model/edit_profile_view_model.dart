import 'dart:async';
import 'dart:io';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/get_profile_data_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/upload_photo_use_case.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_view_state.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileViewModel extends Cubit<EditProfileViewState> {
  final GetProfileDataUseCase _getProfileDataUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final _uiEventsController = StreamController<EditProfileUIEvents>.broadcast();
  Stream<EditProfileUIEvents> get uiEventsStream => _uiEventsController.stream;
  EditProfileViewModel(this._getProfileDataUseCase, this._editProfileUseCase,this._uploadPhotoUseCase)
    : super(EditProfileViewState.initial());


  void doIntent(Intent intent) {
    switch (intent) {
      case GetProfileData():
        _getProfileData();
      case EditProfile():
        _editProfile(editProfileRequest: intent.editProfileRequest);
      case UploadPhoto():
        _uploadPhoto(imageFile: intent.imageFile);
      case PickImageFromGallery():
        _uiEventsController.add(PopWithImageSource(ImageSource.gallery));
      case PickImageFromCamera():
        _uiEventsController.add(PopWithImageSource(ImageSource.camera));
      case SelectLocalPhoto():
        emit(state.copyWith(localImage: intent.file));

    }
  }


  void doUIEvent (EditProfileUIEvents event){
    switch(event) {
      case NavigateToResetPasswordEvent():
        _uiEventsController.add(NavigateToResetPasswordEvent());
      case EditProfileViewShowToast():
        _uiEventsController.add(EditProfileViewShowToast());
      case UploadPhotoViewShowToast():
       _uiEventsController.add(UploadPhotoViewShowToast());
      case PopWithImageSource():
        _uiEventsController.add(event);
      case PopScreenEvent():
        _uiEventsController.add(PopScreenEvent());
    }
  }

  void _getProfileData() async {
    emit(state.copyWith(getProfileDateStates: state.getProfileDateStates.loading));
    var response = await _getProfileDataUseCase.call();
    switch (response) {
      case Success<UserEntity>():
        emit(
          state.copyWith(getProfileDateStates: state.getProfileDateStates.loaded(response.data)));
      case Failure<UserEntity>():
        emit(state.copyWith(getProfileDateStates: state.getProfileDateStates.error(response.errorMessage)));
    }
  }


  void _editProfile({required EditProfileRequest editProfileRequest}) async {
    emit(state.copyWith(editProfileStates: state.editProfileStates.loading));
    final response = await _editProfileUseCase.call(editProfileRequest: editProfileRequest);

    switch (response) {
      case Success<UserEntity>():
        emit(state.copyWith(editProfileStates: state.editProfileStates.loaded(response.data)));
        _uiEventsController.add(EditProfileViewShowToast(message: 'Profile updated successfully'));
        _uiEventsController.add(PopScreenEvent());
      case Failure<UserEntity>():
        emit(state.copyWith(editProfileStates: state.editProfileStates.error(response.errorMessage,),),);
        _uiEventsController.add(EditProfileViewShowToast(message: response.errorMessage, isError: true));
    }
  }


  Future<void> _uploadPhoto({
    required File imageFile,
  }) async {
    emit(
      state.copyWith(
        uploadPhotoStates:
        state.uploadPhotoStates.loading,
      ),
    );

    final response =
    await _uploadPhotoUseCase.call(imageFile: imageFile);

    switch (response) {
      case Success<UploadPhotoResponse>():
        emit(state.copyWith(uploadPhotoStates: state.uploadPhotoStates.loaded(response.data),
          localImage: null,
          ),
        );
        _uiEventsController.add(UploadPhotoViewShowToast(message: 'Photo uploaded successfully'));

        _getProfileData();
      case Failure<UploadPhotoResponse>():
        emit(state.copyWith(uploadPhotoStates:state.uploadPhotoStates.error(response.errorMessage),
            localImage: null,
          ),
        );

        _uiEventsController.add(UploadPhotoViewShowToast(message: response.errorMessage,isError: true));
    }
  }

  @override
  Future<void> close() {
    _uiEventsController.close();
    return super.close();
  }
}


