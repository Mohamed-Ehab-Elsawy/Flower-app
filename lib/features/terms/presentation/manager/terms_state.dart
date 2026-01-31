import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';

class TermsState extends Equatable {
  final BaseState<List<TermsEntity>> state;

  const TermsState(this.state);

  factory TermsState.init() => TermsState(BaseState.init());

  TermsState copyWith(BaseState<List<TermsEntity>>? state) =>
      TermsState(state ?? this.state);

  @override
  List<Object?> get props => [state];
}
