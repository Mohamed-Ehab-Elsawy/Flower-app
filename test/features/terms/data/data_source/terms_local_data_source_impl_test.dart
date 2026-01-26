import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/terms/data/data_source/terms_local_data_source_impl.dart';
import 'package:flower_app/features/terms/data/models/terms_response_dto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'terms_local_data_source_impl_test.mocks.dart';

@GenerateMocks([AssetBundle])
void main() {
  late TermsLocalDataSourceImpl dataSource;
  late MockAssetBundle mockAssetBundle;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    dataSource = TermsLocalDataSourceImpl(assetBundle: mockAssetBundle);
  });

  const tJsonString = '{"id": 1, "content": "terms"}';

  test('should return Success', () async {
    // Arrange
    when(mockAssetBundle.loadString(any)).thenAnswer((_) async => tJsonString);

    // Act
    final result = await dataSource.getTerms();

    // Assert
    expect(result, isA<Success<TermsResponseDTO>>());
  });

  test('should return Failure on error', () async {
    // Arrange
    when(
      mockAssetBundle.loadString(any),
    ).thenThrow(Exception('File not found'));

    // Act
    final result = await dataSource.getTerms();

    // Assert
    expect(result, isA<Failure<TermsResponseDTO>>());
  });
}
