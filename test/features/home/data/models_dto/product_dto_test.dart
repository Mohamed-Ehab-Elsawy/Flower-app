import 'package:flower_app/core/app/data/mapper/product_mapper.dart';
import 'package:flower_app/core/app/data/models/product_dto.dart' show ProductDto;
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductDto productDto;
  group(" test toEntity in ProductsDto", () {
    test(
      'test toEntity with null value it should return UserEntity with null value',
      () {
        productDto = const ProductDto(id: null, title: null, description: null);
        final result = productDto.toEntity();
        expect(result.id, isNull);
        expect(result.title, isNull);
        expect(result.description, isNull);
      },
    );
    test(
      'test toEntity with  value it should return UserEntity with same value',
      () {
       const productDto = ProductDto(
          id: "144",
          title: "title",
          description: "description",
        );

        final result = productDto.toEntity();
        expect(result.id, equals(productDto.id));
        expect(result.title, equals(productDto.title));
        expect(result.description, equals(productDto.description));
      },
    );
  });
}
