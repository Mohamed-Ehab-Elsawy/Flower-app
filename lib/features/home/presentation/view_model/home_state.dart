import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';

class HomeState extends Equatable {
  final BaseState<HomeResponseEntity> homeState;

  const HomeState(this.homeState);

  HomeState copyWith(BaseState<HomeResponseEntity>? baseState) {
    return HomeState(baseState ?? homeState);
  }

  @override
  List<Object?> get props => [homeState];
}
