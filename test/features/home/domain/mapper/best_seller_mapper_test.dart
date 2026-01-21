import 'package:flower_app/features/home/data/models/best_seller_dto.dart';
import 'package:flower_app/features/home/domain/mapper/best_seller_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('bestSellerMapper Extension Tests ', () {
    test(
      'when call bestSellerMapper it should return bestSellerEntity object with correct values ',
      () {
        // arrange
        final dto = BestSellerDto(
          id: "123",
          title: "test",
          price: 200,
          priceAfterDiscount: 150,
          imgCover: "flowerImg",
        );
        // act
        final entity = dto.toProductsEntity();
        // assert
        expect(entity.id, dto.id);
        expect(entity.title, dto.title);
        expect(entity.price, dto.price);
        expect(entity.priceAfterDiscount, dto.priceAfterDiscount);
        expect(entity.imageCover, dto.imgCover);
        expect(entity.discount, 25.0);
      },
    );
    test('when call bestSellerMapper with null values ', () {
      // arrange
      final dto = BestSellerDto(id: null, title: null);
      // act
      final entity = dto.toProductsEntity();
      // assert
      expect(entity.id, null);
      expect(entity.title, null);
    });
  });
}
