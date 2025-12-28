import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:flower_app/features/home/domain/usecases/get_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_products_test.mocks.dart';
@GenerateMocks([HomeRepo])
void main() {
  late GetProductsUseCase getProductsUseCase;
  late MockHomeRepo mockHomeRepo;
  late List<ProductsEntity> productsEntityList;
  late String? categoryId ;
  late String? occasionId ;
  setUpAll((){
    mockHomeRepo =MockHomeRepo();
    getProductsUseCase=GetProductsUseCase(mockHomeRepo);
    productsEntityList = [
      ProductsEntity(id: '1', title: 'title', description: 'description'),
      ProductsEntity(id: '2', title: 'title', description: 'description'),
    ];
    provideDummy<Result<List<ProductsEntity>>>(
      Success<List<ProductsEntity>>(productsEntityList),
    );
    categoryId = "category_1";
    occasionId = "occasion_1";
  });
  test('test call getProductsUseCase to return  productsEntityList for all products', ()async {
    when(mockHomeRepo.getProducts()).thenAnswer((_) async => Success<List<ProductsEntity>>(productsEntityList));
    await getProductsUseCase.call();
    verify(mockHomeRepo.getProducts()).called(1);
  });
  test('test call getProductsUseCase to return  productsEntityList for occasion products only', ()async {
    when(mockHomeRepo.getProducts(occasionId: occasionId)).thenAnswer((_) async => Success<List<ProductsEntity>>(productsEntityList));
    await getProductsUseCase.call(occasionId: occasionId);
    verify(mockHomeRepo.getProducts(occasionId: occasionId)).called(1);
  });
  test('test call getProductsUseCase to return  productsEntityList for category products only', ()async {
    when(mockHomeRepo.getProducts(categoryId:categoryId)).thenAnswer((_) async => Success<List<ProductsEntity>>(productsEntityList));
    await getProductsUseCase.call(categoryId:categoryId);
    verify(mockHomeRepo.getProducts(categoryId:categoryId)).called(1);
  });

}