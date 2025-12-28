import 'package:flower_app/features/home/data/models_dto/product_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductsDto productDto;
  group(" test toEntity in ProductsDto", () {
    test(
      'test toEntity with null value it should return UserEntity with null value',
      () {
        productDto = ProductsDto(id: null, title: null, description: null);
        final result = productDto.toEntity();
        expect(result.id, isNull);
        expect(result.title, isNull);
        expect(result.description, isNull);
      },
    );
    test(
      'test toEntity with  value it should return UserEntity with same value',
      () {
        productDto = ProductsDto(
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
