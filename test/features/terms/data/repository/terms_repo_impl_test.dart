import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/terms/data/data_source/terms_local_data_source.dart';
import 'package:flower_app/features/terms/data/repository/terms_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_app/features/terms/data/models/terms_response_dto.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';

import 'terms_repo_impl_test.mocks.dart';

@GenerateMocks([TermsLocalDataSource])
void main() {
  late TermsRepoImpl repository;
  late MockTermsLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockTermsLocalDataSource();
    repository = TermsRepoImpl(mockDataSource);
  });

  group('getTermsAndConditions', () {
    final tTermsResponseDTO = TermsResponseDTO(terms: []);

    test(
      'should return Success with List<TermsEntity> when DataSource returns Success',
      () async {
        // Arrange
        provideDummy<Result<TermsResponseDTO>>(Success(tTermsResponseDTO));
        when(
          mockDataSource.getTerms(),
        ).thenAnswer((_) async => Success(tTermsResponseDTO));

        // Act
        final result = await repository.getTermsAndConditions();

        // Assert
        expect(result, isA<Success<List<TermsEntity>>>());
        verify(mockDataSource.getTerms()).called(1);
      },
    );

    test('should return Failure when DataSource returns Failure', () async {
      // Arrange
      const tErrorMessage = "File not found";
      provideDummy<Result<TermsResponseDTO>>(Failure(tErrorMessage));
      when(
        mockDataSource.getTerms(),
      ).thenAnswer((_) async => Failure<TermsResponseDTO>(tErrorMessage));

      // Act
      final result = await repository.getTermsAndConditions();

      // Assert
      expect(result, isA<Failure<List<TermsEntity>>>());
      final failureResult = result as Failure;
      expect(failureResult.errorMessage, equals(tErrorMessage));
      verify(mockDataSource.getTerms()).called(1);
    });
  });
}
