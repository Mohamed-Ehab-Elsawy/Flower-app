import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/assets_manager.dart';
import 'package:flower_app/features/terms/data/data_source/terms_local_data_source_impl.dart';
import 'package:flower_app/features/terms/data/models/terms_response_dto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'terms_local_data_source_impl_test.mocks.dart';

@GenerateMocks([AssetBundle])
void main() {
  late TermsLocalDataSourceImpl dataSource;
  late AssetBundle assetBundle;

  setUp(() {
    assetBundle = MockAssetBundle();
    dataSource = TermsLocalDataSourceImpl(
      assetBundle: assetBundle,
    );
  });

  const tJsonString = '{"id": 1, "content": "terms"}';

  test('should return Success', () async {
    // Arrange
    when(
      assetBundle.loadString(AssetsManager.termsJsonPath),
    ).thenAnswer((_) async => tJsonString);

    // Act
    final result = await dataSource.getTerms();

    // Assert
    expect(result, isA<Success<TermsResponseDTO>>());
  });

  test('should return Failure on error', () async {
    // Arrange
    when(
      assetBundle.loadString(AssetsManager.termsJsonPath),
    ).thenThrow(Exception('File not found'));

    // Act
    final result = await dataSource.getTerms();

    // Assert
    expect(result, isA<Failure<TermsResponseDTO>>());
  });
}
