import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:flower_app/features/home/domain/usecases/get_best_seller_use_case.dart';
import 'package:flower_app/features/home/presentation/cubit/best_seller_state.dart';
import 'package:flower_app/features/home/presentation/cubit/best_seller_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'best_seller_view_model_test.mocks.dart';

// Generate Mocks for the UseCase
@GenerateMocks([GetBestSellerUseCase])
void main() {
  late MockGetBestSellerUseCase mockGetBestSellerUseCase;
  late BestSellerViewModel viewModel;

  setUp(() {
    mockGetBestSellerUseCase = MockGetBestSellerUseCase();
    viewModel = BestSellerViewModel(mockGetBestSellerUseCase);
  });

  group('BestSellerViewModel Unit Tests', () {
    final tBestSellerEntity = [
      ProductsEntity(id: '1'),
      ProductsEntity(id: '1'),
    ]; // Mock Data
    const tErrorMessage = "Network Connection Error";

    test('initial state should be BaseState.init()', () {
      expect(viewModel.state.bestSellerState.requestState, RequestState.init);
    });

    blocTest<BestSellerViewModel, BestSellerState>(
      'emits [Loading, Loaded] when GetBestSellerIntent is successful',
      build: () {
        // Arrange
        provideDummy<Result<List<ProductsEntity>>>(Success(tBestSellerEntity));
        when(
          mockGetBestSellerUseCase.invoke(),
        ).thenAnswer((_) async => Success(tBestSellerEntity));
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(GetBestSellerIntent()),
      expect: () => [
        // assert
        isA<BestSellerState>().having(
          (s) => s.bestSellerState.requestState,
          'requestState',
          RequestState.loading,
        ),

        isA<BestSellerState>().having(
          (s) => s.bestSellerState.requestState,
          'requestState',
          RequestState.loaded,
        ),
      ],
      verify: (_) {
        verify(mockGetBestSellerUseCase.invoke()).called(1);
      },
    );

    blocTest<BestSellerViewModel, BestSellerState>(
      'emits [Loading, Error] when GetBestSellerIntent fails',
      build: () {
        // Arrange
        provideDummy<Result<BestSellerEntity>>(Failure(tErrorMessage));
        when(
          mockGetBestSellerUseCase.invoke(),
        ).thenAnswer((_) async => Failure(tErrorMessage));
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(GetBestSellerIntent()),
      expect: () => [
        // Assert: 1st State -> Loading
        isA<BestSellerState>().having(
          (s) => s.bestSellerState.requestState,
          'requestState',
          RequestState.loading,
        ),
        // Assert: 2nd State -> Error (Displays error message)
        isA<BestSellerState>()
            .having(
              (s) => s.bestSellerState.requestState,
              'requestState',
              RequestState.error,
            )
            .having(
              (s) => s.bestSellerState.errorMessage,
              'errorMessage',
              tErrorMessage,
            ),
      ],
    );
  });
}
