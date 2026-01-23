import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/logout_response_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  test('tests calling logout in use_cases.dart', () async {
    LogoutResponseEntity logoutResponseEntity = LogoutResponseEntity(
      message: "message",
    );
    provideDummy<Result<LogoutResponseEntity>>(
      Success<LogoutResponseEntity>(logoutResponseEntity),
    );
    MockAuthRepo mockRepo = MockAuthRepo();
    LogoutUseCase useCase = LogoutUseCase(mockRepo);

    when(mockRepo.logout()).thenAnswer(
      (_) async => Success<LogoutResponseEntity>(logoutResponseEntity),
    );
    await useCase.call();
    verify(mockRepo.logout()).called(1);
  });
}
