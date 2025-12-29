import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';

class HomeState {
  final BaseState<HomeResponseEntity> homeState;

  HomeState(this.homeState);

  HomeState copyWith({BaseState<HomeResponseEntity>? homeState}) {
    return HomeState(homeState ?? this.homeState);
  }
}
