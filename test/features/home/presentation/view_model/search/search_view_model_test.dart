import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flower_app/features/home/presentation/view_model/search/search_intent.dart';
import 'package:flower_app/features/home/presentation/view_model/search/search_state.dart';
import 'package:flower_app/features/home/presentation/view_model/search/search_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_view_model_test.mocks.dart';

@GenerateMocks([GetProductsUseCase])
void main() {
  late SearchViewModel searchViewModel;
  late MockGetProductsUseCase mockGetProductsUseCase;
  late List<ProductsEntity> productsEntityList;

  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();
    searchViewModel = SearchViewModel(mockGetProductsUseCase);
    productsEntityList = [
      ProductsEntity(
        id: '1',
        title: 'Rose Bouquet',
        description: 'Beautiful roses',
        imageCover: 'imageCover',
        price: 100.0,
        priceAfterDiscount: 80.0,
        quantity: 10,
        categoryId: 'categoryId',
        occasionId: 'occasionId',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSuperAdmin: true,
        sold: 5,
        slug: 'rose-bouquet',
        ratingAverage: 4.5,
        ratingCount: 10,
        images: const ["image1.jpg", "image2.jpg"],
      ),
      ProductsEntity(
        id: '2',
        title: 'Tulip Arrangement',
        description: 'Fresh tulips',
        imageCover: 'imageCover2',
        price: 120.0,
        priceAfterDiscount: 100.0,
        quantity: 15,
        categoryId: 'categoryId',
        occasionId: 'occasionId',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSuperAdmin: true,
        sold: 8,
        slug: 'tulip-arrangement',
        ratingAverage: 4.8,
        ratingCount: 20,
        images: const ["image3.jpg", "image4.jpg"],
      ),
    ];

    provideDummy<Result<List<ProductsEntity>>>(
      Success<List<ProductsEntity>>(productsEntityList),
    );
  });

  tearDown(() {
    searchViewModel.close();
  });

  group('SearchViewModel Initial State', () {
    test('initial state should be SearchState with init BaseState', () {
      expect(searchViewModel.state, SearchState.initial());
      expect(searchViewModel.state.searchState.isInitial, true);
    });
  });

  group('SearchKeywordChanged Intent', () {
    blocTest<SearchViewModel, SearchState>(
      'emits [loading, loaded] when search succeeds with valid keyword',
      build: () {
        when(mockGetProductsUseCase(keyword: 'rose')).thenAnswer(
              (_) async => Success<List<ProductsEntity>>(productsEntityList),
        );
        return searchViewModel;
      },
      act: (bloc) => bloc.doIntent(SearchKeywordChanged('rose')),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        SearchState(searchState: BaseState.loading()),
        SearchState(searchState: BaseState.loaded(productsEntityList)),
      ],
      verify: (_) {
        verify(mockGetProductsUseCase(keyword: 'rose')).called(1);
      },
    );

    blocTest<SearchViewModel, SearchState>(
      'emits [loading, error] when search fails',
      build: () {
        when(mockGetProductsUseCase(keyword: 'rose')).thenAnswer(
              (_) async => Failure<List<ProductsEntity>>('Network error'),
        );
        return searchViewModel;
      },
      act: (bloc) => bloc.doIntent(SearchKeywordChanged('rose')),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        SearchState(searchState: BaseState.loading()),
        SearchState(searchState: BaseState.error('Network error')),
      ],
      verify: (_) {
        verify(mockGetProductsUseCase(keyword: 'rose')).called(1);
      },
    );

    blocTest<SearchViewModel, SearchState>(
      'emits initial state when keyword is empty',
      build: () => searchViewModel,
      act: (bloc) => bloc.doIntent(SearchKeywordChanged('')),
      expect: () => [SearchState.initial()],
      verify: (_) {
        verifyNever(mockGetProductsUseCase(keyword: anyNamed('keyword')));
      },
    );

    blocTest<SearchViewModel, SearchState>(
      'emits initial state when keyword is only spaces',
      build: () => searchViewModel,
      act: (bloc) => bloc.doIntent(SearchKeywordChanged('   ')),
      expect: () => [SearchState.initial()],
      verify: (_) {
        verifyNever(mockGetProductsUseCase(keyword: anyNamed('keyword')));
      },
    );

    blocTest<SearchViewModel, SearchState>(
      'trims keyword before searching',
      build: () {
        when(mockGetProductsUseCase(keyword: 'rose')).thenAnswer(
              (_) async => Success<List<ProductsEntity>>(productsEntityList),
        );
        return searchViewModel;
      },
      act: (bloc) => bloc.doIntent(SearchKeywordChanged('  rose  ')),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        SearchState(searchState: BaseState.loading()),
        SearchState(searchState: BaseState.loaded(productsEntityList)),
      ],
      verify: (_) {
        verify(mockGetProductsUseCase(keyword: 'rose')).called(1);
      },
    );

    blocTest<SearchViewModel, SearchState>(
      'debounces multiple keyword changes and only searches for last one',
      build: () {
        when(mockGetProductsUseCase(keyword: 'roses')).thenAnswer(
              (_) async => Success<List<ProductsEntity>>(productsEntityList),
        );
        return searchViewModel;
      },
      act: (bloc) async {
        bloc.doIntent(SearchKeywordChanged('r'));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.doIntent(SearchKeywordChanged('ro'));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.doIntent(SearchKeywordChanged('ros'));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.doIntent(SearchKeywordChanged('rose'));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.doIntent(SearchKeywordChanged('roses'));
      },
      wait: const Duration(milliseconds: 600),
      expect: () => [
        SearchState(searchState: BaseState.loading()),
        SearchState(searchState: BaseState.loaded(productsEntityList)),
      ],
      verify: (_) {
        verify(mockGetProductsUseCase(keyword: 'roses')).called(1);
        verifyNever(mockGetProductsUseCase(keyword: 'r'));
        verifyNever(mockGetProductsUseCase(keyword: 'ro'));
        verifyNever(mockGetProductsUseCase(keyword: 'ros'));
        verifyNever(mockGetProductsUseCase(keyword: 'rose'));
      },
    );
  });

  group('SearchCleared Intent', () {
    blocTest<SearchViewModel, SearchState>(
      'emits initial state when SearchCleared is called',
      build: () => searchViewModel,
      act: (bloc) => bloc.doIntent(SearchCleared()),
      expect: () => [SearchState.initial()],
    );

    blocTest<SearchViewModel, SearchState>(
      'cancels debounce timer when SearchCleared is called',
      build: () {
        when(mockGetProductsUseCase(keyword: 'rose')).thenAnswer(
              (_) async => Success<List<ProductsEntity>>(productsEntityList),
        );
        return searchViewModel;
      },
      act: (bloc) async {
        bloc.doIntent(SearchKeywordChanged('rose'));
        await Future.delayed(const Duration(milliseconds: 200));
        bloc.doIntent(SearchCleared());
      },
      wait: const Duration(milliseconds: 600),
      expect: () => [SearchState.initial()],
      verify: (_) {
        verifyNever(mockGetProductsUseCase(keyword: anyNamed('keyword')));
      },
    );
  });

  group('ProductTapped Intent', () {
    test('emits OpenProductDetails event when product is tapped', () async {
      final product = productsEntityList.first;

      expectLater(
        searchViewModel.uiEventsStream,
        emits(isA<OpenProductDetails>().having(
              (event) => event.product,
          'product',
          product,
        )),
      );

      searchViewModel.doIntent(ProductTapped(product));
    });

    test('emits correct product in OpenProductDetails event', () async {
      final product = productsEntityList[1];

      expectLater(
        searchViewModel.uiEventsStream,
        emits(isA<OpenProductDetails>().having(
              (event) => event.product.id,
          'product id',
          '2',
        )),
      );

      searchViewModel.doIntent(ProductTapped(product));
    });
  });

  group('SearchViewModel Cleanup', () {
    test('closes stream controller when ViewModel is closed', () async {
      final viewModel = SearchViewModel(mockGetProductsUseCase);

      expect(viewModel.uiEventsStream, isA<Stream<SearchUIEvents>>());

      await viewModel.close();

      expect(
            () => viewModel.doIntent(ProductTapped(productsEntityList.first)),
        returnsNormally,
      );
    });
  });
}