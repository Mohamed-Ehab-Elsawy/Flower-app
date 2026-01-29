import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';

class SearchState extends Equatable {
  final BaseState<List<ProductsEntity>> searchState;
  const SearchState({required this.searchState});

  factory SearchState.initial() => SearchState(searchState: BaseState.init());

  SearchState copyWith({BaseState<List<ProductsEntity>>? searchState}) {
    return SearchState(searchState: searchState ?? this.searchState);
  }

  @override
  List<Object?> get props => [searchState];
}
