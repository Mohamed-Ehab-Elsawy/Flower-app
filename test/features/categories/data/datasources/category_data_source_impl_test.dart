import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/app/data/models/product_type_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/categories/data/datasources/category_data_source.dart';
import 'package:flower_app/features/categories/data/datasources/category_data_source_impl.dart';
import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../home/data/datasources/home_data_source_impl_test.mocks.dart';

void main() {
  late ApiClient apiClient;
  late CategoryDataSource categoryDataSource;
  late CategoriesResponse categoriesResponse;
  late ProductTypeDto categoryDto;
  late List<ProductTypeDto> categoriesDto;
  late Exception exception;

  setUp(() {
    apiClient = MockApiClient();
    categoryDataSource = CategoryDataSourceImpl(apiClient);

    categoryDto = ProductTypeDto(
      id: 'id',
      name: 'name',
      slug: 'slug',
      image: 'image',
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
      isSuperAdmin: false,
    );
    categoriesDto = [categoryDto, categoryDto, categoryDto];
    categoriesResponse = CategoriesResponse(categories: categoriesDto);

    exception = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );
  });

  test(
    "When i call getCategories from categoryDataSource it calls getCategories from apiClient"
    "and returns a list of categories after mapping them to entities and Success result",
    () async {
      // arrange
      when(
        apiClient.getCategories(),
      ).thenAnswer((_) async => categoriesResponse);

      // act
      var result =
          await categoryDataSource.getCategories()
              as Success<List<ProductTypeDto>>;

      // assert
      expect(result.data.length, categoriesDto.length);
      verify(apiClient.getCategories()).called(1);
      verifyNoMoreInteractions(apiClient);
    },
  );

  test(
    "When i call getCategories from categoryDataSource it calls getCategories from apiClient"
    "and returns Failure result with error message if there is an error",
    () async {
      // arrange
      when(apiClient.getCategories()).thenThrow(exception);

      // act
      var result =
          await categoryDataSource.getCategories()
              as Failure<List<ProductTypeDto>>;

      // assert
      expect(result.errorMessage, "errors.connectionError");
      verify(apiClient.getCategories()).called(1);
      verifyNoMoreInteractions(apiClient);
    },
  );
}
