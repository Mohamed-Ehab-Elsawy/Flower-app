import 'package:flower_app/features/home/data/models/best_seller_dto.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flower_app/features/home/domain/mapper/best_seller_response_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test best seller response mapper cases', () {
    test(
      'when call bestSellerMapper it should return bestSellerEntity object with correct values',
      () {
        // arrange
        final dto = BestSellerResponse(
          message: "success",
          bestSeller: [
            BestSellerDto(
              id: "123",
              title: "test",
              price: 200,
              priceAfterDiscount: 150,
              imgCover: "flowerImg",
            ),
          ],
        );
        // act
        final entity = dto.toModel();
        // assert
        expect(entity.massage, dto.message);
        expect(entity.bestSellerItemEntityList?.length, dto.bestSeller?.length);
        expect(entity.bestSellerItemEntityList?[0].id, dto.bestSeller?[0].id);
        expect(
          entity.bestSellerItemEntityList?[0].title,
          dto.bestSeller?[0].title,
        );
        expect(
          entity.bestSellerItemEntityList?[0].price,
          dto.bestSeller?[0].price,
        );
        expect(
          entity.bestSellerItemEntityList?[0].priceAfterDiscount,
          dto.bestSeller?[0].priceAfterDiscount,
        );
        expect(
          entity.bestSellerItemEntityList?[0].imgCover,
          dto.bestSeller?[0].imgCover,
        );
      },
    );
    test('when call bestSellerMapper with null values ', () {
      // arrange
      final dto = BestSellerResponse(message: null, bestSeller: null);
      // act
      final entity = dto.toModel();
      // assert
      expect(entity.massage, dto.message);
      expect(entity.bestSellerItemEntityList, dto.bestSeller);
    });
  });
}
