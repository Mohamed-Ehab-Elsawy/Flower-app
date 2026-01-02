import 'package:flower_app/core/app/domain/entities/product_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/models_dto/product_response.dart';
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
  late List<ProductEntity> productsEntityList;
  late ProductResponse productResponse;
  late String? occasionId;
  late Exception exception;
  setUp(() {
    mockOccasionUseCase = MockGetProductsUseCase();
    productResponse = ProductResponse(message: "message");
    productsEntityList = [
      ProductEntity(
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
        images: ["httpng", "httpsg"],
      ),
      ProductEntity(
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
        images: ["httpng", "httpsg"],
      ),
    ];
    occasionId = "occasion_1";
    provideDummy<Result<List<ProductEntity>>>(
      Success<List<ProductEntity>>(productsEntityList),
    );
    exception = Exception("message");
  });

  blocTest<OccasionsCubit, OccasionsStates>(
    ' emits [loading, success] when getProductsUseCase returns Success',
    build: () {
      when(mockOccasionUseCase(occasionId: occasionId)).thenAnswer(
        (_) async => Success<List<ProductEntity>>(productsEntityList),
      );
      return OccasionsCubit(mockOccasionUseCase);
    },
    act: (bloc) => bloc.doIntent(
      GetAllProductsByOccasionsEvents(occasionId: occasionId ?? ""),
    ),
    expect: () {
      var state = const OccasionsStates(
        productsState: BaseState<List<ProductEntity>>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          productsState: const BaseState<List<ProductEntity>>(
            requestState: RequestState.loading,
          ),
        ),

        state.copyWith(
          productsState: BaseState<List<ProductEntity>>(
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
        (_) async => Failure<List<ProductEntity>>(exception.toString()),
      );
      return OccasionsCubit(mockOccasionUseCase);
    },
    act: (bloc) => bloc.doIntent(
      GetAllProductsByOccasionsEvents(occasionId: occasionId ?? ""),
    ),
    expect: () {
      var state = const OccasionsStates(
        productsState: BaseState<List<ProductEntity>>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          productsState: const BaseState<List<ProductEntity>>(
            requestState: RequestState.loading,
          ),
        ),

        state.copyWith(
          productsState: BaseState<List<ProductEntity>>(
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
