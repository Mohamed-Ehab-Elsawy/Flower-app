import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/mapper/home_response_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('home response mapper ...', () {
    var dto = HomeResponseDto(message: "success");
    var entity = dto.toEntity();
    expect(entity, HomeResponseEntity(message: "success"));
  });
}
