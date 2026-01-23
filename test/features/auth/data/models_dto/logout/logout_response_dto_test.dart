import 'package:flower_app/features/auth/data/models_dto/logout/logout_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LogoutResponseDto logoutResponseDto;
  group(" test toEntity in LogoutResponseDto", () {
    logoutResponseDto = LogoutResponseDto(message: null);

    test(
      'test toEntity with null value it should return LogoutResponseDto with null value',
      () {
        final result = logoutResponseDto.toEntity();
        expect(result.message, isNull);
      },
    );
    test(
      'test toEntity with  value it should return LogoutResponseDto with same value',
      () {
        final result = logoutResponseDto.toEntity();
        expect(result.message, equals(logoutResponseDto.message));
      },
    );
  });
}
