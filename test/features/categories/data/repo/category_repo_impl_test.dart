import 'package:flower_app/core/app/data/models/product_type_dto.dart';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/categories/data/datasources/category_data_source.dart';
import 'package:flower_app/features/categories/data/datasources/category_data_source_impl.dart';
import 'package:flower_app/features/categories/data/repo/category_repo_impl.dart';
import 'package:flower_app/features/categories/domain/repo/category_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_repo_impl_test.mocks.dart';

@GenerateMocks([CategoryDataSourceImpl])
void main() {
  late CategoryDataSource categoryDataSource;
  late CategoryRepo categoryRepo;
  late ProductTypeDto categoryDto;
  late List<ProductTypeDto> categoriesDto;
  late ProductTypeEntity categoryEntity;
  late List<ProductTypeEntity> categories;
  late Result<List<ProductTypeDto>> response;

  setUp(() {
    categoryDataSource = MockCategoryDataSourceImpl();
    categoryRepo = CategoryRepoImpl(categoryDataSource);

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
  });

  test(
    "When i call getCategories from categoryRepo it calls getCategories from categoryDataSource"
    "and returns a list of categories when Success result",
    () async {
      // arrange
      response = Success(categoriesDto);
      provideDummy<Result<List<ProductTypeDto>>>(response);
      when(
        categoryDataSource.getCategories(),
      ).thenAnswer((_) async => response);

      // act
      var result =
          await categoryRepo.getCategories()
              as Success<List<ProductTypeEntity>>;

      // assert
      verify(categoryDataSource.getCategories()).called(1);
      verifyNoMoreInteractions(categoryDataSource);
      expect(result.data.length, categories.length);
    },
  );

  test(
    "When i call getCategories from categoryRepo it calls getCategories from categoryDataSource"
    "and returns Failure result with error message if there is an error",
    () async {
      // arrange
      response = Failure<List<ProductTypeDto>>('errors.connectionError');
      provideDummy<Result<List<ProductTypeDto>>>(response);
      when(
        categoryDataSource.getCategories(),
      ).thenAnswer((_) async => response);

      // act
      var result =
          await categoryRepo.getCategories()
              as Failure<List<ProductTypeEntity>>;

      // assert
      verify(categoryDataSource.getCategories()).called(1);
      verifyNoMoreInteractions(categoryDataSource);
      expect(result.errorMessage, 'errors.connectionError');
    },
  );
}
