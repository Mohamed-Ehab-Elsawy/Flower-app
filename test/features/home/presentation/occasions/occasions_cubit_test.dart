
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_cubit.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_events.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'occasions_cubit_test.mocks.dart';

@GenerateMocks([GetProductsUseCase])
void main() {
  late MockGetProductsUseCase mockOccasionUseCase;
  late List<ProductsEntity> productsEntityList;
  late String? occasionId;
  late Exception exception;
  setUp(() {
    mockOccasionUseCase = MockGetProductsUseCase();
    productsEntityList = [
      ProductsEntity(
        id: '1',
        title: 'title',
        description: 'description',
        imageCover: 'imageCover',
        price: 10.0,
        priceAfterDiscount: 5.0,
        quantity: 10,
        categoryId: 'categoryId',
        occasionId: 'occasionId',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSuperAdmin: true,
        sold: 10,
        slug: '',
        ratingAverage: null,
        ratingCount: null,
        images: const ["httpng", "httpsg"],
      ),
      ProductsEntity(
        id: '1',
        title: 'title',
        description: 'description',
        imageCover: 'imageCover',
        price: 10.0,
        priceAfterDiscount: 5.0,
        quantity: 10,
        categoryId: 'categoryId',
        occasionId: 'occasionId',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSuperAdmin: true,
        sold: 10,
        slug: '',
        ratingAverage: null,
        ratingCount: null,
        images: const ["httpng", "httpsg"],
      ),
    ];
    occasionId = "occasion_1";
    provideDummy<Result<List<ProductsEntity>>>(
      Success<List<ProductsEntity>>(productsEntityList),
    );
    exception = Exception("message");
  });

  blocTest<OccasionsCubit, OccasionsStates>(
    ' emits [loading, success] when getProductsUseCase returns Success',
    build: () {
      when(mockOccasionUseCase(occasionId: occasionId)).thenAnswer(
        (_) async => Success<List<ProductsEntity>>(productsEntityList),
      );
      return OccasionsCubit(mockOccasionUseCase);
    },
    act: (bloc) => bloc.doIntent(
      GetAllProductsByOccasionsEvents(occasionId: occasionId ?? ""),
    ),
    expect: () {
      var state = const OccasionsStates(
        productsState: BaseState<List<ProductsEntity>>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          productsState: const BaseState<List<ProductsEntity>>(
            requestState: RequestState.loading,
          ),
        ),

        state.copyWith(
          productsState: BaseState<List<ProductsEntity>>(
            data: productsEntityList,
            requestState: RequestState.loaded,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockOccasionUseCase(occasionId: occasionId)).called(1);
    },
  );
  blocTest<OccasionsCubit, OccasionsStates>(
    ' emits [loading, failure] when getProductsUseCase returns failure ',
    build: () {
      when(mockOccasionUseCase(occasionId: occasionId)).thenAnswer(
        (_) async => Failure<List<ProductsEntity>>(exception.toString()),
      );
      return OccasionsCubit(mockOccasionUseCase);
    },
    act: (bloc) => bloc.doIntent(
      GetAllProductsByOccasionsEvents(occasionId: occasionId ?? ""),
    ),
    expect: () {
      var state = const OccasionsStates(
        productsState: BaseState<List<ProductsEntity>>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          productsState: const BaseState<List<ProductsEntity>>(
            requestState: RequestState.loading,
          ),
        ),

        state.copyWith(
          productsState: BaseState<List<ProductsEntity>>(
            requestState: RequestState.error,
            errorMessage: exception.toString(),
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockOccasionUseCase(occasionId: occasionId)).called(1);
    },
  );
}
