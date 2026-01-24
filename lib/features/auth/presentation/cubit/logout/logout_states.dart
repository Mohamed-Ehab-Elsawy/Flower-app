import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/auth/domain/models/logout_response_entity.dart';

class LogoutStates extends Equatable {
  final BaseState<LogoutResponseEntity>? logoutState;

  const LogoutStates({this.logoutState});

  @override
  List<Object?> get props => [logoutState];

  LogoutStates copyWith({BaseState<LogoutResponseEntity>? logoutState}) {
    return LogoutStates(logoutState: logoutState ?? this.logoutState);
  }
}
