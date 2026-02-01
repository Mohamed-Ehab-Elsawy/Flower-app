import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/profile/domain/entity/about_us_entity.dart';

final class AboutUsState extends Equatable {
  final BaseState<AboutUsEntity> aboutStates;
  const AboutUsState({required this.aboutStates});
  factory AboutUsState.init() => AboutUsState(aboutStates: BaseState.init());
  AboutUsState copyWith({BaseState<AboutUsEntity>? aboutStates}) {
    return AboutUsState(aboutStates: aboutStates ?? this.aboutStates);
  }

  @override
  List<Object?> get props => [aboutStates];
}
