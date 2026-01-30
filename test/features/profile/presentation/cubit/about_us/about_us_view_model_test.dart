import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/domain/entity/about_us_entity.dart';
import 'package:flower_app/features/profile/domain/usecases/about_us_use_case.dart';
import 'package:flower_app/features/profile/presentation/cubit/about_us/about_us_intents.dart';
import 'package:flower_app/features/profile/presentation/cubit/about_us/about_us_state.dart';
import 'package:flower_app/features/profile/presentation/cubit/about_us/about_us_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'about_us_view_model_test.mocks.dart';

@GenerateMocks([AboutUsUseCase])
void main() {
  late AboutUsViewModel viewModel;
  late MockAboutUsUseCase mockAboutUsUseCase;

  setUp(() {
    mockAboutUsUseCase = MockAboutUsUseCase();
    viewModel = AboutUsViewModel(mockAboutUsUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  group("AboutUsViewModel Tests", () {
    const mockEntity = AboutUsEntity(sections: []);
    final successResponse = Success<AboutUsEntity>(mockEntity);
    final failureResponse = Failure<AboutUsEntity>("Error");

    test("initial state should be init", () {
      expect(viewModel.state.aboutStates.isInitial, isTrue);
    });

    blocTest<AboutUsViewModel, AboutUsState>(
      "emits [Loading, Loaded] when GetAboutUsIntent succeeds",
      build: () {
        provideDummy<Result<AboutUsEntity>>(successResponse);
        when(
          mockAboutUsUseCase.invoke(),
        ).thenAnswer((_) async => successResponse);
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(GetAboutUsIntent()),
      expect: () => [
        isA<AboutUsState>().having(
          (s) => s.aboutStates.isLoading,
          "is loading",
          isTrue,
        ),
        isA<AboutUsState>().having(
          (s) => s.aboutStates.isLoaded,
          "is loaded",
          isTrue,
        ),
      ],
      verify: (_) => verify(mockAboutUsUseCase.invoke()).called(1),
    );

    blocTest<AboutUsViewModel, AboutUsState>(
      "emits [Loading, Error] when GetAboutUsIntent fails",
      build: () {
        provideDummy<Result<AboutUsEntity>>(failureResponse);
        when(
          mockAboutUsUseCase.invoke(),
        ).thenAnswer((_) async => failureResponse);
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(GetAboutUsIntent()),
      expect: () => [
        isA<AboutUsState>().having(
          (s) => s.aboutStates.isLoading,
          "is loading",
          isTrue,
        ),
        isA<AboutUsState>().having(
          (s) => s.aboutStates.isError,
          "is error",
          isTrue,
        ),
      ],
    );

    test("should emit BackToProfileIntent on uiEvents stream", () async {
      expectLater(viewModel.uiEvents, emits(isA<BackToProfileIntent>()));
      viewModel.doIntent(BackToProfileIntent());
    });
  });
}
