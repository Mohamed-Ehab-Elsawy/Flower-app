import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/get_profile_data_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/upload_photo_use_case.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_view_state.dart';
import 'package:image_picker/image_picker.dart';

import 'edit_profile_view_model_test.mocks.dart';

@GenerateMocks([GetProfileDataUseCase, EditProfileUseCase, UploadPhotoUseCase])
void main() {
  late EditProfileViewModel viewModel;
  late MockGetProfileDataUseCase mockGetProfileDataUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;

  setUp(() {
    mockGetProfileDataUseCase = MockGetProfileDataUseCase();
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();
    viewModel = EditProfileViewModel(
      mockGetProfileDataUseCase,
      mockEditProfileUseCase,
      mockUploadPhotoUseCase,
    );
  });

  tearDown(() {
    viewModel.close();
  });

  group('GetProfileData Intent Tests', () {
    final userEntity = UserEntity(
      id: "1",
      firstName: "Test User",
      email: "test@test.com",
      phone: "01234567890",
    );
    final successResponse = Success<UserEntity>(userEntity);
    final failureResponse = Failure<UserEntity>("Failed to get profile data");

    blocTest<EditProfileViewModel, EditProfileViewState>(
      'should emit [loading, loaded] when getProfileData succeeds',
      build: () => viewModel,
      setUp: () {
        provideDummy<Result<UserEntity>>(successResponse);
        when(
          mockGetProfileDataUseCase.call(),
        ).thenAnswer((_) async => successResponse);
      },
      act: (bloc) => bloc.doIntent(GetProfileData()),
      expect: () => [
        EditProfileViewState.initial().copyWith(
          getProfileDateStates: BaseState<UserEntity>.loading(),
        ),
        EditProfileViewState.initial().copyWith(
          getProfileDateStates: BaseState<UserEntity>.loaded(userEntity),
        ),
      ],
      verify: (_) {
        verify(mockGetProfileDataUseCase.call()).called(1);
      },
    );

    blocTest<EditProfileViewModel, EditProfileViewState>(
      'should emit [loading, error] when getProfileData fails',
      build: () => viewModel,
      setUp: () {
        provideDummy<Result<UserEntity>>(failureResponse);
        when(
          mockGetProfileDataUseCase.call(),
        ).thenAnswer((_) async => failureResponse);
      },
      act: (bloc) => bloc.doIntent(GetProfileData()),
      expect: () => [
        EditProfileViewState.initial().copyWith(
          getProfileDateStates: BaseState<UserEntity>.loading(),
        ),
        EditProfileViewState.initial().copyWith(
          getProfileDateStates: BaseState<UserEntity>.error(
            "Failed to get profile data",
          ),
        ),
      ],
      verify: (_) {
        verify(mockGetProfileDataUseCase.call()).called(1);
      },
    );
  });

  group('EditProfile Intent Tests', () {
    const editProfileRequest = EditProfileRequest(
      firstName: "Mohamed",
      lastName: "Kamal",
      email: "updated@test.com",
      phone: "01111111111",
    );
    final userEntity = UserEntity(
      id: "1",
      firstName: "Mohamed",
      lastName: "Kamal",
      email: "updated@test.com",
      phone: "01111111111",
    );
    final successResponse = Success<UserEntity>(userEntity);
    final failureResponse = Failure<UserEntity>("Failed to edit profile");

    blocTest<EditProfileViewModel, EditProfileViewState>(
      'should emit [loading, loaded] when editProfile succeeds',
      build: () => viewModel,
      setUp: () {
        provideDummy<Result<UserEntity>>(successResponse);
        when(
          mockEditProfileUseCase.call(editProfileRequest: editProfileRequest),
        ).thenAnswer((_) async => successResponse);
      },
      act: (bloc) => bloc.doIntent(EditProfile(editProfileRequest)),
      expect: () => [
        EditProfileViewState.initial().copyWith(
          editProfileStates: BaseState<UserEntity>.loading(),
        ),
        EditProfileViewState.initial().copyWith(
          editProfileStates: BaseState<UserEntity>.loaded(userEntity),
        ),
      ],
      verify: (_) {
        verify(
          mockEditProfileUseCase.call(editProfileRequest: editProfileRequest),
        ).called(1);
      },
    );

    blocTest<EditProfileViewModel, EditProfileViewState>(
      'should emit [loading, error] when editProfile fails',
      build: () => viewModel,
      setUp: () {
        provideDummy<Result<UserEntity>>(failureResponse);
        when(
          mockEditProfileUseCase.call(editProfileRequest: editProfileRequest),
        ).thenAnswer((_) async => failureResponse);
      },
      act: (bloc) => bloc.doIntent(EditProfile(editProfileRequest)),
      expect: () => [
        EditProfileViewState.initial().copyWith(
          editProfileStates: BaseState<UserEntity>.loading(),
        ),
        EditProfileViewState.initial().copyWith(
          editProfileStates: BaseState<UserEntity>.error(
            "Failed to edit profile",
          ),
        ),
      ],
      verify: (_) {
        verify(
          mockEditProfileUseCase.call(editProfileRequest: editProfileRequest),
        ).called(1);
      },
    );
  });

  group('UploadPhoto Intent Tests', () {
    late File testImageFile;
    const uploadPhotoResponse = UploadPhotoResponse(
      message: "Photo uploaded successfully",
    );
    final successResponse = Success<UploadPhotoResponse>(uploadPhotoResponse);
    final failureResponse = Failure<UploadPhotoResponse>(
      "Failed to upload photo",
    );
    final userEntity = UserEntity(
      id: "1",
      firstName: "Test User",
      email: "test@test.com",
      phone: "01234567890",
    );
    final getUserSuccessResponse = Success<UserEntity>(userEntity);

    setUp(() {
      testImageFile = File('test/fixtures/test_image.jpg')
        ..createSync(recursive: true)
        ..writeAsBytesSync([1, 2, 3, 4, 5]);
    });

    tearDown(() {
      if (testImageFile.existsSync()) {
        testImageFile.deleteSync();
      }
    });

    blocTest<EditProfileViewModel, EditProfileViewState>(
      'should emit [loading, loaded] and refetch profile when uploadPhoto succeeds',
      build: () => viewModel,
      setUp: () {
        provideDummy<Result<UploadPhotoResponse>>(successResponse);
        provideDummy<Result<UserEntity>>(getUserSuccessResponse);
        when(
          mockUploadPhotoUseCase.call(imageFile: testImageFile),
        ).thenAnswer((_) async => successResponse);
        when(
          mockGetProfileDataUseCase.call(),
        ).thenAnswer((_) async => getUserSuccessResponse);
      },
      act: (bloc) => bloc.doIntent(UploadPhoto(testImageFile)),
      expect: () => [
        EditProfileViewState.initial().copyWith(
          uploadPhotoStates: BaseState<UploadPhotoResponse>.loading(),
        ),
        EditProfileViewState.initial().copyWith(
          uploadPhotoStates: BaseState<UploadPhotoResponse>.loaded(
            uploadPhotoResponse,
          ),
          localImage: null,
        ),
        EditProfileViewState.initial().copyWith(
          uploadPhotoStates: BaseState<UploadPhotoResponse>.loaded(
            uploadPhotoResponse,
          ),
          localImage: null,
          getProfileDateStates: BaseState<UserEntity>.loading(),
        ),
        EditProfileViewState.initial().copyWith(
          uploadPhotoStates: BaseState<UploadPhotoResponse>.loaded(
            uploadPhotoResponse,
          ),
          localImage: null,
          getProfileDateStates: BaseState<UserEntity>.loaded(userEntity),
        ),
      ],
      verify: (_) {
        verify(mockUploadPhotoUseCase.call(imageFile: testImageFile)).called(1);
        verify(mockGetProfileDataUseCase.call()).called(1);
      },
    );

    blocTest<EditProfileViewModel, EditProfileViewState>(
      'should emit [loading, error] and clear localImage when uploadPhoto fails',
      build: () => viewModel,
      setUp: () {
        provideDummy<Result<UploadPhotoResponse>>(failureResponse);
        when(
          mockUploadPhotoUseCase.call(imageFile: testImageFile),
        ).thenAnswer((_) async => failureResponse);
      },
      act: (bloc) => bloc.doIntent(UploadPhoto(testImageFile)),
      expect: () => [
        EditProfileViewState.initial().copyWith(
          uploadPhotoStates: BaseState<UploadPhotoResponse>.loading(),
        ),
        EditProfileViewState.initial().copyWith(
          uploadPhotoStates: BaseState<UploadPhotoResponse>.error(
            "Failed to upload photo",
          ),
          localImage: null,
        ),
      ],
      verify: (_) {
        verify(mockUploadPhotoUseCase.call(imageFile: testImageFile)).called(1);
        verifyNever(mockGetProfileDataUseCase.call());
      },
    );
  });

  group('SelectLocalPhoto Intent Tests', () {
    late File testImageFile;

    setUp(() {
      testImageFile = File('test/fixtures/test_image.jpg')
        ..createSync(recursive: true)
        ..writeAsBytesSync([1, 2, 3, 4, 5]);
    });

    tearDown(() {
      if (testImageFile.existsSync()) {
        testImageFile.deleteSync();
      }
    });

    blocTest<EditProfileViewModel, EditProfileViewState>(
      'should update localImage when SelectLocalPhoto intent is called',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(SelectLocalPhoto(testImageFile)),
      expect: () => [
        EditProfileViewState.initial().copyWith(localImage: testImageFile),
      ],
    );
  });

  group('PickImageFromGallery Intent Tests', () {
    blocTest<EditProfileViewModel, EditProfileViewState>(
      'should emit PopWithImageSource(gallery) when PickImageFromGallery is called',
      build: () => viewModel,
      act: (bloc) {
        expectLater(
          viewModel.uiEventsStream,
          emits(
            predicate<PopWithImageSource>(
              (event) => event.source == ImageSource.gallery,
            ),
          ),
        );
        bloc.doIntent(PickImageFromGallery());
      },
      expect: () => [],
    );
  });

  group('PickImageFromCamera Intent Tests', () {
    blocTest<EditProfileViewModel, EditProfileViewState>(
      'should emit PopWithImageSource(camera) when PickImageFromCamera is called',
      build: () => viewModel,
      act: (bloc) {
        expectLater(
          viewModel.uiEventsStream,
          emits(
            predicate<PopWithImageSource>(
              (event) => event.source == ImageSource.camera,
            ),
          ),
        );
        bloc.doIntent(PickImageFromCamera());
      },
      expect: () => [],
    );
  });

  group('UI Events Tests', () {
    test(
      'should emit NavigateToResetPasswordEvent when doUIEvent is called',
      () async {
        expectLater(
          viewModel.uiEventsStream,
          emits(isA<NavigateToResetPasswordEvent>()),
        );
        viewModel.doUIEvent(NavigateToResetPasswordEvent());
      },
    );

    test('should emit PopScreenEvent when doUIEvent is called', () async {
      expectLater(viewModel.uiEventsStream, emits(isA<PopScreenEvent>()));
      viewModel.doUIEvent(PopScreenEvent());
    });
  });
}
