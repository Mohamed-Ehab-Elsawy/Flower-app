import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/usecases/fetch_home_data_usecase.dart';
import 'package:flower_app/features/home/presentation/view_model/home_state.dart';
import 'package:flower_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_view_model_test.mocks.dart';

@GenerateMocks([FetchHomeDataUsecase])
void main() {
  late HomeViewModel homeViewModel;
  late FetchHomeDataUsecase fetchHomeDataUseCase;
  setUp(() {
    fetchHomeDataUseCase = MockFetchHomeDataUsecase();
    homeViewModel = HomeViewModel(fetchHomeDataUseCase);
  });
  final successResponse = Success(const HomeResponseEntity(message: "success"));
  final failureResponse = Failure<HomeResponseEntity>("error");
  group("TEST HomeViewModel", () {
    blocTest<HomeViewModel, HomeState>(
      'emits [loading, loaded] when FetchHomeDataUsecase is triggered',
      build: () => homeViewModel,
      setUp: () {
        provideDummy<Result<HomeResponseEntity>>(successResponse);
        when(
          fetchHomeDataUseCase.call(),
        ).thenAnswer((_) async => successResponse);
      },
      act: (bloc) => bloc.doIntent(FetchHomeData()),
      expect: () {
        var state = HomeState(BaseState<HomeResponseEntity>.init());
        return [
          state.copyWith(
            const BaseState<HomeResponseEntity>(
              requestState: RequestState.loading,
            ),
          ),
          state.copyWith(
            BaseState<HomeResponseEntity>(
              requestState: RequestState.loaded,
              data: successResponse.data,
            ),
          ),
        ];
      },
    );
    blocTest<HomeViewModel, HomeState>(
      'emits [loading, error] when FetchHomeDataUsecase is triggered',
      build: () => homeViewModel,
      setUp: () {
        provideDummy<Result<HomeResponseEntity>>(failureResponse);
        when(
          fetchHomeDataUseCase.call(),
        ).thenAnswer((_) async => failureResponse);
      },
      act: (bloc) => bloc.doIntent(FetchHomeData()),
      expect: () {
        var state = HomeState(BaseState<HomeResponseEntity>.init());
        return [
          state.copyWith(
            const BaseState<HomeResponseEntity>(
              requestState: RequestState.loading,
            ),
          ),
          state.copyWith(
            BaseState<HomeResponseEntity>(
              requestState: RequestState.error,
              errorMessage: failureResponse.errorMessage,
            ),
          ),
        ];
      },
    );
  });
}
