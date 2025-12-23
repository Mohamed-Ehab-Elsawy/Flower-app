import 'package:flower_app/features/auth/domain/use_cases/forget_password/reset_password_use_case.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/send_reset_password_code_use_case.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/verify_reset_password_code_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([
  ResetPasswordUseCase,
  SendResetPasswordCodeUseCase,
  VerifyResetPasswordCodeUseCase,
])
void main() {
  late ForgetPasswordCubit cubit;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockSendResetPasswordCodeUseCase mockSendResetPasswordCodeUseCase;
  late MockVerifyResetPasswordCodeUseCase mockVerifyResetPasswordCodeUseCase;
  const testEmail = 'test@example.com';
  const testCode = '123456';
  const testPassword = 'newPassword123';

  setUpAll(() {
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockSendResetPasswordCodeUseCase = MockSendResetPasswordCodeUseCase();
    mockVerifyResetPasswordCodeUseCase = MockVerifyResetPasswordCodeUseCase();
  });
  setUp(() {
    cubit = ForgetPasswordCubit(
      mockSendResetPasswordCodeUseCase,
      mockVerifyResetPasswordCodeUseCase,
      mockResetPasswordUseCase,
    );
  });
  group('forget password view model test success cases', () {
    blocTest(
      'When the user enters a valid email and submits it ',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(SendResetPasswordCodeIntent(testEmail)),
      expect: () => [],
    );
  });
}
