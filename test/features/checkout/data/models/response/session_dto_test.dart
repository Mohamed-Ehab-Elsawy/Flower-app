import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SessionDto sessionDto;

  test('test  toEntity method should return sessionEntity with same value', () {
    sessionDto = SessionDto(
      id: "id",
      object: "object",
      afterExpiration: "afterExpiration",
      allowPromotionCodes: "allowPromotionCodes",
      amountTotal: 0,
    );
    final result = sessionDto.toEntity();
    expect(result.id, equals(sessionDto.id));
    expect(result.object, equals(sessionDto.object));
    expect(result.afterExpiration, equals(sessionDto.afterExpiration));
    expect(result.allowPromotionCodes, equals(sessionDto.allowPromotionCodes));
    expect(result.amountTotal, equals(sessionDto.amountTotal));
  });
  test(
    'test  toEntity method with null value should return sessionEntity with null value',
    () {
      sessionDto = SessionDto(
        id: null,
        object: null,
        afterExpiration: null,
        allowPromotionCodes: null,
        amountTotal: null,
      );
      final result = sessionDto.toEntity();
      expect(result.id, isNull);
      expect(result.object, isNull);
      expect(result.afterExpiration, isNull);
      expect(result.allowPromotionCodes, isNull);
      expect(result.amountTotal, isNull);
    },
  );
}
