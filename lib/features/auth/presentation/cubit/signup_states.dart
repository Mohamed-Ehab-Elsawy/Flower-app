import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';


class SignupStates extends Equatable {
  final BaseState<UserEntity>? signUpStates;
  const SignupStates({this.signUpStates});
  @override
  List<Object?> get props => [signUpStates];
  SignupStates copyWith({BaseState<UserEntity>? signUpState}) {
    return SignupStates(signUpStates: signUpState ?? signUpStates);
  }
}
