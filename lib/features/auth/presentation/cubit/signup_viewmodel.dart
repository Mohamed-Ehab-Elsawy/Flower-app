import 'package:equatable/equatable.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_event.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpViewModel extends Cubit<SignupStates> with EquatableMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
   String selectedGender='female';
  final SignUpUseCase _signUpUseCase;

  SignUpViewModel(this._signUpUseCase) : super(SignupStates());
  @override
  List<Object> get props {
    return [state];
  }

  void doIntent(SignupEvent event) {
    switch (event) {
      case SignUpEvent():
        _signUp(event.userRequest);
    }
  }

  void _signUp(UserRequest userRequest) async {
    emit(
      state.copyWith(
        signUpState: BaseState<UserEntity>(requestState: RequestState.loading),
      ),
    );
    Result<UserEntity> response = await _signUpUseCase(userRequest);
    switch (response) {
      case Success<UserEntity>():
        emit(
          state.copyWith(
            signUpState: BaseState<UserEntity>.loaded(response.data),
          ),
        );
      case Failure<UserEntity>():
        emit(
          state.copyWith(
            signUpState: BaseState<UserEntity>.error(
              response.errorMessage.toString(),
            ),
          ),
        );
    }
  }
}
