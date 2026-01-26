import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';
import 'package:flower_app/features/terms/domain/repository/terms_repo.dart';
import 'package:flower_app/features/terms/presentation/manager/terms_intent.dart';
import 'package:flower_app/features/terms/presentation/manager/terms_state.dart';
import 'package:flower_app/features/terms/presentation/view_model/terms_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'terms_view_model_test.mocks.dart';

@GenerateMocks([TermsRepo])
void main() {
  late TermsViewModel viewModel;
  late MockTermsRepo mockTermsRepo;

  setUp(() {
    mockTermsRepo = MockTermsRepo();
    viewModel = TermsViewModel(mockTermsRepo);
  });

  final tTermsList = [
    TermsEntity(
      section: "Policy",
      contentEn: ["Text"],
      contentAr: ["نص"],
      fontSize: 14.0,
      colorHex: "#000000",
      fontWeight: "normal",
    ),
  ];

  group('TermsViewModel Tests', () {
    blocTest<TermsViewModel, TermsState>(
      'should emit [loading, loaded] when fetching terms is successful',
      build: () {
        provideDummy<Result<List<TermsEntity>>>(Success(tTermsList));
        when(
          mockTermsRepo.getTermsAndConditions(),
        ).thenAnswer((_) async => Success(tTermsList));
        return viewModel;
      },
      act: (vm) => vm.doIntent(FetchTermsIntent()),
      expect: () => [
        // 1. Verify it transitions to RequestState.loading
        isA<TermsState>().having(
          (s) => s.state.requestState,
          'requestState',
          RequestState.loading,
        ),
        // 2. Verify it transitions to RequestState.loaded with correct data
        isA<TermsState>()
            .having(
              (s) => s.state.requestState,
              'requestState',
              RequestState.loaded,
            )
            .having((s) => s.state.data, 'data', tTermsList),
      ],
    );

    blocTest<TermsViewModel, TermsState>(
      'should emit [loading, error] when fetching terms fails',
      build: () {
        provideDummy<Result<List<TermsEntity>>>(Failure("Server Error"));
        when(
          mockTermsRepo.getTermsAndConditions(),
        ).thenAnswer((_) async => Failure("Server Error"));
        return viewModel;
      },
      act: (vm) => vm.doIntent(FetchTermsIntent()),
      expect: () => [
        isA<TermsState>().having(
          (s) => s.state.requestState,
          'requestState',
          RequestState.loading,
        ),
        isA<TermsState>()
            .having(
              (s) => s.state.requestState,
              'requestState',
              RequestState.error,
            )
            .having(
              (s) => s.state.errorMessage,
              'errorMessage',
              "Server Error",
            ),
      ],
    );
  });
}
