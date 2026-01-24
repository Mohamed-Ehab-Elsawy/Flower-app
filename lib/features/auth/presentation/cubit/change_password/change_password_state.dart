import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/auth/data/models/response/change_password_response.dart';

class ChangePasswordState extends Equatable {
  final BaseState<ChangePasswordResponse> changePasswordState;
  const ChangePasswordState(this.changePasswordState);

  ChangePasswordState copyWith(BaseState<ChangePasswordResponse>? baseState) {
    return ChangePasswordState(baseState ?? changePasswordState);
  }

  @override
  List<Object> get props => [changePasswordState];
}
