import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_intents.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_states.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesViewCubit extends Cubit<CategoriesViewStates> {
  final GetProductsUseCase _getProductsUseCase;

  CategoriesViewCubit(this._getProductsUseCase)
    : super(
        const CategoriesViewStates(
          categories: ["All", "Flowers", "Plants", "Seeds", "Tools"],
          selectedIndex: 0,
        ),
      );

  List<ProductsEntity> products = [];

  void doIntent(CategoriesViewIntents intent) {
    switch (intent) {
      case GetProductsByCategoryIntent():
        _getAllProductsByOccasions();
    }
  }

  Future<void> _getAllProductsByOccasions({String? categoryId}) async {
    emit(
      state.copyWith(
        productsState: const BaseState<List<ProductsEntity>>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<List<ProductsEntity>> response = await _getProductsUseCase(
      occasionId: categoryId,
    );
    switch (response) {
      case Success<List<ProductsEntity>>():
        {
          products = response.data;
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

  List<Object> get props {
    return [state];
  }
}
