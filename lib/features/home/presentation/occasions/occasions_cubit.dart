import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_events.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:injectable/injectable.dart';

import '../../domain/entities/product_entity.dart';

@injectable
class OccasionsCubit extends Cubit<OccasionsStates> {
  final GetProductsUseCase _getProductsUseCase;

  OccasionsCubit(this._getProductsUseCase) : super(OccasionsStates());
  String occasionId = "673b35c01159920171827aed";

  List<Object> get props {
    return [state];
  }

  void doIntent(OccasionsEvents event) {
    switch (event) {
      case GetAllProductsByOccasionsEvents():
        _getAllProductsByOccasions(event.occasionId);
    }
  }

  Future<void> _getAllProductsByOccasions(String? occasionId) async {
    emit(
      state.copyWith(
        productsState: const BaseState<List<ProductsEntity>>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<List<ProductsEntity>> response = await _getProductsUseCase(
      occasionId: occasionId,
    );
    switch (response) {
      case Success<List<ProductsEntity>>():
        {
          emit(
            state.copyWith(
              productsState: BaseState<List<ProductsEntity>>.loaded(
                response.data,
              ),
            ),
          );
        }

      case Failure<List<ProductsEntity>>():
        {
          emit(
            state.copyWith(
              productsState: BaseState<List<ProductsEntity>>.error(
                response.errorMessage,
              ),
            ),
          );
        }
    }
  }
}
