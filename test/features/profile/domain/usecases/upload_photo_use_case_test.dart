import 'dart:io';
import 'package:flower_app/features/profile/domain/usecases/upload_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';

import 'get_profile_data_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late File imageFile;
  late UploadPhotoResponse uploadPhotoResponse;
  late Success<UploadPhotoResponse> successResponse;
  late Failure<UploadPhotoResponse> failureResponse;
  late MockProfileRepo mockProfileRepo;
  late UploadPhotoUseCase uploadPhotoUseCase;

  setUp(() {
    imageFile = File('test_image.jpg');
    uploadPhotoResponse = const UploadPhotoResponse(
      message: "Photo uploaded successfully",
    );
    successResponse = Success<UploadPhotoResponse>(uploadPhotoResponse);
    failureResponse = Failure<UploadPhotoResponse>("Failed to upload photo");
    mockProfileRepo = MockProfileRepo();
    uploadPhotoUseCase = UploadPhotoUseCase(mockProfileRepo);
  });

  test(
    'should return Success with UploadPhotoResponse when uploadPhoto succeeds',
    () async {
      // Arrange
      provideDummy<Result<UploadPhotoResponse>>(successResponse);
      when(
        mockProfileRepo.uploadPhoto(imageFile: imageFile),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await uploadPhotoUseCase.call(imageFile: imageFile);

      // Assertion And Verifications
      expect(result, isA<Success<UploadPhotoResponse>>());
      expect(
        (result as Success<UploadPhotoResponse>).data.message,
        equals("Photo uploaded successfully"),
      );
      verify(mockProfileRepo.uploadPhoto(imageFile: imageFile)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    },
  );

  test('should return Failure when uploadPhoto fails', () async {
    // Arrange
    provideDummy<Result<UploadPhotoResponse>>(failureResponse);
    when(
      mockProfileRepo.uploadPhoto(imageFile: imageFile),
    ).thenAnswer((_) async => failureResponse);

    // Act
    final result = await uploadPhotoUseCase.call(imageFile: imageFile);

    // Assertion And Verifications
    expect(result, isA<Failure<UploadPhotoResponse>>());
    expect(
      (result as Failure<UploadPhotoResponse>).errorMessage,
      equals("Failed to upload photo"),
    );
    verify(mockProfileRepo.uploadPhoto(imageFile: imageFile)).called(1);
    verifyNoMoreInteractions(mockProfileRepo);
  });
}
