import 'dart:io';

import 'package:flower_app/features/profile/data/data_source/profile_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/data/data_source/profile_remote_data_source_impl.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/get_user_data_response.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/profile/data/repositories/profile_repo_impl.dart';

import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSourceImpl, ProfileLocalDataSourceImpl])
void main() {
  // Arrange
  late MockProfileRemoteDataSourceImpl mockProfileDataSource;
  late MockProfileLocalDataSourceImpl mockProfileLocalDataSource;
  late ProfileRepoImpl profileRepoImpl;

  setUp(() {
    mockProfileDataSource = MockProfileRemoteDataSourceImpl();
    mockProfileLocalDataSource = MockProfileLocalDataSourceImpl();
    profileRepoImpl = ProfileRepoImpl(
      mockProfileDataSource,
      mockProfileLocalDataSource,
    );
  });

  group("Get Profile Data Test Cases", () {
    late UserDto userDto;
    late UserEntity userEntity;
    late GetUserDataResponse getUserDataResponse;
    late Success<GetUserDataResponse> successResponse;
    late Failure<GetUserDataResponse> failureResponse;

    setUp(() {
      userDto = UserDto(
        id: "1",
        firstName: "Test User",
        email: "test@test.com",
        phone: "01234567890",
      );
      userEntity = userDto.toEntity();
      getUserDataResponse = GetUserDataResponse(user: userDto);
      successResponse = Success<GetUserDataResponse>(getUserDataResponse);
      failureResponse = Failure<GetUserDataResponse>(
        "Failed to get profile data",
      );
    });

    test("when call getProfileData Success Case", () async {
      // Arrange
      provideDummy<Result<GetUserDataResponse>>(successResponse);
      when(
        mockProfileDataSource.getProfileData(),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await profileRepoImpl.getProfileData();

      // Assertion And Verification
      expect((result as Success<UserEntity>).data.id, userEntity.id);
      expect(result.data.firstName, userEntity.firstName);
      expect(result.data.email, userEntity.email);
      verify(mockProfileDataSource.getProfileData()).called(1);
      verifyNoMoreInteractions(mockProfileDataSource);
    });

    test(
      "when getProfileData throws exception it should return Failure",
      () async {
        // Arrange
        provideDummy<Result<GetUserDataResponse>>(failureResponse);
        when(
          mockProfileDataSource.getProfileData(),
        ).thenAnswer((_) async => failureResponse);

        // Act
        final result = await profileRepoImpl.getProfileData();

        // Assertion And Verification
        expect(result, isA<Failure<UserEntity>>());
        expect(
          (result as Failure<UserEntity>).errorMessage,
          "Failed to get profile data",
        );
        verify(mockProfileDataSource.getProfileData()).called(1);
        verifyNoMoreInteractions(mockProfileDataSource);
      },
    );
  });

  group("Edit Profile Test Cases", () {
    late EditProfileRequest editProfileRequest;
    late UserDto userDto;
    late GetUserDataResponse getUserDataResponse;
    late Success<GetUserDataResponse> successResponse;
    late Failure<GetUserDataResponse> failureResponse;

    setUp(() {
      editProfileRequest = const EditProfileRequest(
        firstName: "Mohamed",
        lastName: "Kamal",
        email: "updated@test.com",
        phone: "01111111111",
      );
      userDto = UserDto(
        id: "1",
        firstName: "Updated Name",
        email: "updated@test.com",
        phone: "01111111111",
      );
      getUserDataResponse = GetUserDataResponse(user: userDto);
      successResponse = Success<GetUserDataResponse>(getUserDataResponse);
      failureResponse = Failure<GetUserDataResponse>("Failed to edit profile");
    });

    test("when call editProfile Success Case", () async {
      // Arrange
      provideDummy<Result<GetUserDataResponse>>(successResponse);
      when(
        mockProfileDataSource.editProfile(
          editProfileRequest: editProfileRequest,
        ),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await profileRepoImpl.editProfile(
        editProfileRequest: editProfileRequest,
      );

      // Assertion And Verification
      expect(result, isA<Success<UserEntity>>());
      expect((result as Success<UserEntity>).data.firstName, "Updated Name");
      expect(result.data.email, "updated@test.com");
      verify(
        mockProfileDataSource.editProfile(
          editProfileRequest: editProfileRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockProfileDataSource);
    });

    test(
      "when editProfile throws exception it should return Failure",
      () async {
        // Arrange
        provideDummy<Result<GetUserDataResponse>>(failureResponse);
        when(
          mockProfileDataSource.editProfile(
            editProfileRequest: editProfileRequest,
          ),
        ).thenAnswer((_) async => failureResponse);

        // Act
        final result = await profileRepoImpl.editProfile(
          editProfileRequest: editProfileRequest,
        );

        // Assertion And Verification
        expect(result, isA<Failure<UserEntity>>());
        expect(
          (result as Failure<UserEntity>).errorMessage,
          "Failed to edit profile",
        );
        verify(
          mockProfileDataSource.editProfile(
            editProfileRequest: editProfileRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockProfileDataSource);
      },
    );
  });

  group("Upload Photo Test Cases", () {
    late File testImageFile;
    late UploadPhotoResponse uploadPhotoResponse;
    late Success<UploadPhotoResponse> successResponse;
    late Failure<UploadPhotoResponse> failureResponse;

    setUpAll(() {
      final fixturesDir = Directory('test/fixtures');
      if (!fixturesDir.existsSync()) {
        fixturesDir.createSync(recursive: true);
      }

      // Create a dummy image file for testing
      testImageFile = File('test/fixtures/test_image.jpg');
      if (!testImageFile.existsSync()) {
        // Write some dummy bytes to create the file
        testImageFile.writeAsBytesSync([
          0xFF, 0xD8, 0xFF, 0xE0, 0x00, 0x10, 0x4A, 0x46, // JPEG header
          0x49, 0x46, 0x00, 0x01, 0x01, 0x00, 0x00, 0x01,
          0x00, 0x01, 0x00, 0x00, 0xFF, 0xD9, // JPEG footer
        ]);
      }
    });

    setUp(() {
      uploadPhotoResponse = const UploadPhotoResponse(
        message: "Photo uploaded successfully",
      );
      successResponse = Success<UploadPhotoResponse>(uploadPhotoResponse);
      failureResponse = Failure<UploadPhotoResponse>("Failed to upload photo");
    });

    tearDownAll(() {
      if (testImageFile.existsSync()) {
        testImageFile.deleteSync();
      }
    });

    test("when call uploadPhoto Success Case", () async {
      // Arrange
      provideDummy<Result<UploadPhotoResponse>>(successResponse);
      when(
        mockProfileDataSource.uploadPhoto(photo: anyNamed('photo')),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await profileRepoImpl.uploadPhoto(
        imageFile: testImageFile,
      );

      // Assertion And Verification
      expect(
        (result as Success<UploadPhotoResponse>).data.message,
        "Photo uploaded successfully",
      );
      verify(
        mockProfileDataSource.uploadPhoto(photo: anyNamed('photo')),
      ).called(1);
      verifyNoMoreInteractions(mockProfileDataSource);
    });

    test(
      "when uploadPhoto throws exception it should return Failure",
      () async {
        // Arrange
        provideDummy<Result<UploadPhotoResponse>>(failureResponse);
        when(
          mockProfileDataSource.uploadPhoto(photo: anyNamed('photo')),
        ).thenAnswer((_) async => failureResponse);

        // Act
        final result = await profileRepoImpl.uploadPhoto(
          imageFile: testImageFile,
        );

        // Assertion And Verification
        expect(result, isA<Failure<UploadPhotoResponse>>());
        expect(
          (result as Failure<UploadPhotoResponse>).errorMessage,
          "Failed to upload photo",
        );
        verify(
          mockProfileDataSource.uploadPhoto(photo: anyNamed('photo')),
        ).called(1);
        verifyNoMoreInteractions(mockProfileDataSource);
      },
    );
  });
}
