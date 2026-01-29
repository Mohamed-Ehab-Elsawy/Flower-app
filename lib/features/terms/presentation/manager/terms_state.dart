import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';

class TermsState {
  BaseState<List<TermsEntity>> state;

  TermsState(this.state);

  factory TermsState.init() => TermsState(BaseState.init());

  TermsState copyWith(BaseState<List<TermsEntity>>? state) =>
      TermsState(state ?? this.state);
}
