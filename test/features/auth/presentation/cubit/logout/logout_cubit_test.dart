import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/logout_response_entity.dart';
import 'package:flower_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/logout/logout_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/logout/logout_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/logout/logout_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_cubit_test.mocks.dart';

@GenerateMocks([LogoutUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockLogoutUseCase mockUseCase;
  late LogoutCubit viewModel;
  late LogoutResponseEntity dummyResponse;

  setUp(() {
    mockUseCase = MockLogoutUseCase();
    viewModel = LogoutCubit(mockUseCase);

    dummyResponse = LogoutResponseEntity(message: "success");
    provideDummy<Result<LogoutResponseEntity>>(
      Success<LogoutResponseEntity>(dummyResponse),
    );
  });

  blocTest<LogoutCubit, LogoutStates>(
    ' emits [loading, success] when logoutUseCase returns Success',
    build: () {
      when(
        mockUseCase(),
      ).thenAnswer((_) async => Success<LogoutResponseEntity>(dummyResponse));
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(LogoutEvent()),
    expect: () {
      var state = const LogoutStates(
        logoutState: BaseState<LogoutResponseEntity>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          logoutState: const BaseState<LogoutResponseEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          logoutState: BaseState<LogoutResponseEntity>(
            requestState: RequestState.loaded,
            data: dummyResponse,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockUseCase()).called(1);
    },
  );

  blocTest<LogoutCubit, LogoutStates>(
    ' emits [loading, error] when logoutUseCase returns error',
    build: () {
      when(
        mockUseCase(),
      ).thenAnswer((_) async => Failure<LogoutResponseEntity>("Failed"));
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(LogoutEvent()),
    expect: () {
      var state = const LogoutStates(
        logoutState: BaseState<LogoutResponseEntity>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          logoutState: const BaseState<LogoutResponseEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          logoutState: const BaseState<LogoutResponseEntity>(
            errorMessage: "Failed",
            requestState: RequestState.error,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockUseCase()).called(1);
    },
  );
}
