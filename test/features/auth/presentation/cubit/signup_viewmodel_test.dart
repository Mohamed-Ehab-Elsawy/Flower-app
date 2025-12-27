import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_event.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_states.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_viewmodel_test.mocks.dart';

@GenerateMocks([SignUpUseCase])
void main() {
  late MockSignUpUseCase mockSignUpUseCase;
  late SignUpViewModel viewModel;
  late UserSignupRequest dummyRequest;
  late UserEntity dummyUser;

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    viewModel = SignUpViewModel(mockSignUpUseCase);
    dummyRequest = UserSignupRequest(
      gender: "male",
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      password: "dd",
      rePassword: "dd",
      phone: "12345",
    );
    dummyUser = UserEntity(
      id: "d",
      firstName: "abdo",
      lastName: "abdoa",
      email: "",
      phone: "12345",
      role: "role",
      addresses: [12, 45],
      gender: "male",
      photo: "ddd",
    );
    provideDummy<Result<UserEntity>>(Success<UserEntity>(dummyUser));
  });

  blocTest<SignUpViewModel, SignupStates>(
    ' emits [loading, success] when signUpUseCase returns Success',
    build: () {
      when(
        mockSignUpUseCase(dummyRequest),
      ).thenAnswer((_) async => Success<UserEntity>(dummyUser));
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(SignUpEvent(userRequest: dummyRequest)),
    expect: () {
      var state = const SignupStates(
        signUpState: BaseState<UserEntity>(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          signUpState: const BaseState<UserEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          signUpState: BaseState<UserEntity>(
            data: dummyUser,
            requestState: RequestState.loaded,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockSignUpUseCase(dummyRequest)).called(1);
    },
  );

  blocTest<SignUpViewModel, SignupStates>(
    ' emits [loading, error] when signUpUseCase returns error',
    build: () {
      when(
        mockSignUpUseCase(dummyRequest),
      ).thenAnswer((_) async => Failure<UserEntity>("Signup Failed"));
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(SignUpEvent(userRequest: dummyRequest)),
    expect: () {
      var state = const SignupStates(
        signUpState: BaseState<UserEntity>(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          signUpState: const BaseState<UserEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          signUpState: const BaseState<UserEntity>(
            errorMessage: "Signup Failed",
            requestState: RequestState.error,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockSignUpUseCase(dummyRequest)).called(1);
    },
  );
  blocTest<SignUpViewModel, SignupStates>(
    'emits state with selectedGender when SelectGender event is triggered',
    build: () => viewModel,
    act: (bloc) => bloc.doIntent(SelectGender(selectGender: "male")),
    expect: () => [const SignupStates(selectedGender: "male")],
  );
}
