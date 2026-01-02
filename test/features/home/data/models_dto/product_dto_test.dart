import 'package:flower_app/core/app/data/mapper/product_mapper.dart';
import 'package:flower_app/core/app/data/models/products_dto.dart'
    show ProductsDto;
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductsDto productsDto;
  group(" test toEntity in ProductsDto", () {
    test(
      'test toEntity with null value it should return UserEntity with null value',
      () {
        productsDto = const ProductsDto(
          id: null,
          title: null,
          description: null,
        );
        final result = productsDto.toEntity();
        expect(result.id, isNull);
        expect(result.title, isNull);
        expect(result.description, isNull);
      },
    );
    test(
      'test toEntity with  value it should return UserEntity with same value',
      () {
        const productsDto = ProductsDto(
          id: "144",
          title: "title",
          description: "description",
        );

        final result = productsDto.toEntity();
        expect(result.id, equals(productsDto.id));
        expect(result.title, equals(productsDto.title));
        expect(result.description, equals(productsDto.description));
      },
    );
  });
}
