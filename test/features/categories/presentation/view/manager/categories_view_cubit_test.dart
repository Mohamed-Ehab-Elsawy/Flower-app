import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/categories/domain/usecases/get_categories_use_case.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_events.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_intents.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_model.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_states.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_view_cubit_test.mocks.dart';

@GenerateMocks([GetProductsUseCase, GetCategoriesUseCase])
void main() {
  late GetProductsUseCase getProductsUseCase;
  late GetCategoriesUseCase getCategoriesUseCase;
  late CategoriesViewModel categoriesViewCubit;
  late ProductTypeEntity categoryEntity;
  late List<ProductTypeEntity> categories;
  late ProductsEntity productEntity;
  late List<ProductsEntity> products;
  late Result<List<ProductTypeEntity>> response;

  setUp(() {
    getProductsUseCase = MockGetProductsUseCase();
    getCategoriesUseCase = MockGetCategoriesUseCase();
    categoriesViewCubit = CategoriesViewModel(
      getCategoriesUseCase,
      getProductsUseCase,
    );
    categoryEntity = ProductTypeEntity(
      id: 'id',
      name: 'name',
      slug: 'slug',
      image: 'image',
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
      isSuperAdmin: false,
    );
    categories = [categoryEntity, categoryEntity, categoryEntity];
    productEntity = ProductsEntity(
      id: 'id',
      title: 'title',
      slug: 'slug',
      description: 'description',
      imageCover: 'imageCover',
      images: const ['', '', ''],
      price: 100,
      priceAfterDiscount: 90,
      quantity: 10,
      categoryId: 'categoryId',
      occasionId: 'occasionId',
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
      isSuperAdmin: false,
      sold: 9,
      ratingAverage: 1.2,
      ratingCount: 2,
    );
    products = [productEntity, productEntity, productEntity];
  });

  group("Test doIntents - success case", () {
    blocTest(
      "emits [loading, loaded] when getCategoriesUseCase success",
      build: () => categoriesViewCubit,
      setUp: () {
        response = Success(categories);
        provideDummy<Result<List<ProductTypeEntity>>>(response);
        when(getCategoriesUseCase.call()).thenAnswer((_) async => response);
      },
      act: (bloc) => bloc.doIntent(InitCategoriesViewIntent()),
      expect: () => [
        const CategoriesViewStates(
          categories: BaseState<List<ProductTypeEntity>>(
            requestState: RequestState.loading,
          ),
        ),
        CategoriesViewStates(
          categories: BaseState<List<ProductTypeEntity>>(
            requestState: RequestState.loaded,
            data: categories,
          ),
        ),
      ],
    );

    blocTest(
      "emits [loading, loaded] when getProductsUseCase success",
      build: () => categoriesViewCubit,
      setUp: () {
        final response = Success<List<ProductsEntity>>(products);

        provideDummy<Result<List<ProductsEntity>>>(response);

        when(
          getProductsUseCase.call(categoryId: "1"),
        ).thenAnswer((_) async => response);
      },
      act: (bloc) =>
          bloc.doIntent(GetProductsByCategoryIntent(categoryId: "1")),
      expect: () => [
        const CategoriesViewStates(
          productsStates: BaseState<List<ProductsEntity>>(
            requestState: RequestState.loading,
          ),
        ),
        CategoriesViewStates(
          productsStates: BaseState<List<ProductsEntity>>(
            requestState: RequestState.loaded,
            data: products,
          ),
        ),
      ],
      verify: (_) {
        verify(getProductsUseCase.call(categoryId: "1")).called(1);
      },
    );
  });

  group("Test doIntents – failure case", () {
    blocTest(
      "emits [loading, error] and UI event when getCategoriesUseCase fails",
      build: () => categoriesViewCubit,
      setUp: () {
        response = Failure<List<ProductTypeEntity>>("Network error");
        provideDummy<Result<List<ProductTypeEntity>>>(response);
        when(getCategoriesUseCase.call()).thenAnswer((_) async => response);
      },
      act: (bloc) async {
        final events = <CategoriesViewUIEvents>[];
        final sub = bloc.uiEvents.listen(events.add);

        bloc.doIntent(InitCategoriesViewIntent());

        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        expect(events, [CategoriesViewShowErrorEvent("Network error")]);
      },
      expect: () => [
        const CategoriesViewStates(
          categories: BaseState<List<ProductTypeEntity>>(
            requestState: RequestState.loading,
          ),
        ),
        const CategoriesViewStates(
          categories: BaseState<List<ProductTypeEntity>>(
            requestState: RequestState.error,
            errorMessage: "Network error",
          ),
        ),
      ],
    );

    blocTest<CategoriesViewModel, CategoriesViewStates>(
      "emits [loading, error] and UI event when getProductsUseCase fails",
      build: () => categoriesViewCubit,
      setUp: () {
        final response = Failure<List<ProductsEntity>>("Server error");
        provideDummy<Result<List<ProductsEntity>>>(response);
        when(
          getProductsUseCase.call(categoryId: "1"),
        ).thenAnswer((_) async => response);
      },
      act: (bloc) async {
        final events = <CategoriesViewUIEvents>[];
        final sub = bloc.uiEvents.listen(events.add);

        bloc.doIntent(GetProductsByCategoryIntent(categoryId: "1"));

        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        expect(events, [CategoriesViewShowErrorEvent("Server error")]);
      },
      expect: () => [
        const CategoriesViewStates(
          productsStates: BaseState<List<ProductsEntity>>(
            requestState: RequestState.loading,
          ),
        ),
        const CategoriesViewStates(
          productsStates: BaseState<List<ProductsEntity>>(
            requestState: RequestState.error,
            errorMessage: "Server error",
          ),
        ),
      ],
      verify: (_) {
        verify(getProductsUseCase.call(categoryId: "1")).called(1);
      },
    );
  });
}
