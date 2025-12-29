import 'dart:async';
import 'package:flower_app/core/app/domain/entities/product_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_events.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:injectable/injectable.dart';

@injectable
class OccasionsCubit extends Cubit<OccasionsStates> {
  final GetProductsUseCase _getProductsUseCase;

  OccasionsCubit(this._getProductsUseCase) : super(OccasionsStates());
  final StreamController<OccasionsUiEvent> _occasionsUiEvents =
      StreamController.broadcast();
  Stream<OccasionsUiEvent> get occasionsUiEvent => _occasionsUiEvents.stream;
  void doIntent(OccasionsEvents event) {
    switch (event) {
      case GetAllProductsByOccasionsEvents():
        _getAllProductsByOccasions(event.occasionId);
    }
  }

  void doEvent(OccasionsUiEvent event) {
    switch (event) {
      case NavigateToProductDetails():
        _occasionsUiEvents.add(NavigateToProductDetails());
    }
  }

  Future<void> _getAllProductsByOccasions(String? occasionId) async {
    emit(
      state.copyWith(
        productsState: const BaseState<List<ProductEntity>>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<List<ProductEntity>> response = await _getProductsUseCase(
      occasionId: occasionId,
    );
    switch (response) {
      case Success<List<ProductEntity>>():
        {
          emit(
            state.copyWith(
              productsState: BaseState<List<ProductEntity>>.loaded(
                response.data,
              ),
            ),
          );
        }

      case Failure<List<ProductEntity>>():
        {
          emit(
            state.copyWith(
              productsState: BaseState<List<ProductEntity>>.error(
                response.errorMessage,
              ),
            ),
          );
        }
    }
  }
}
