import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/requests/change_password_request.dart';
import 'package:flower_app/features/auth/data/models/response/change_password_response.dart';
import 'package:flower_app/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/change_password/change_password_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/change_password/change_password_state.dart';
import 'package:flower_app/features/auth/presentation/cubit/change_password/change_password_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_view_model_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ChangePasswordUseCase mockChangePasswordUseCase;
  late ChangePasswordViewModel changePasswordViewModel;
  late Result<ChangePasswordResponse> changePasswordResponse;
  final tRequest = ChangePasswordRequest(
    password: 'Abc@1234',
    newPassword: 'Ab@12345',
  );
  final tResponse = ChangePasswordResponse(
    message: 'Success',
    token: 'token123',
  );
  const tErrorMessage = 'Invalid Password';
  const tSuccessMessage = 'Success';
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
          (MethodCall methodCall) async => null,
        );
    mockChangePasswordUseCase = MockChangePasswordUseCase();
    changePasswordViewModel = ChangePasswordViewModel(
      mockChangePasswordUseCase,
    );
  });

  group("ChangePasswordViewModel Test cases for change password method", () {
    blocTest<ChangePasswordViewModel, ChangePasswordState>(
      'should emit [Loading, Loaded] when change password succeeds',
      build: () {
        changePasswordResponse = Success<ChangePasswordResponse>(tResponse);
        provideDummy<Result<ChangePasswordResponse>>(changePasswordResponse);

        when(
          mockChangePasswordUseCase.changePassword(
            changePasswordRequest: tRequest,
          ),
        ).thenAnswer((_) async => changePasswordResponse);

        return changePasswordViewModel;
      },
      act: (viewModel) => viewModel.doEvent(
        ChangePasswordIntent(changePasswordRequest: tRequest),
      ),
      expect: () => [
        isA<ChangePasswordState>().having(
          (s) => s.changePasswordState.requestState,
          'loading',
          RequestState.loading,
        ),

        isA<ChangePasswordState>().having(
          (s) => s.changePasswordState.requestState,
          'loaded',
          RequestState.loaded,
        ),
      ],
      verify: (_) {
        verify(
          mockChangePasswordUseCase.changePassword(
            changePasswordRequest: tRequest,
          ),
        ).called(1);
      },
    );
    blocTest<ChangePasswordViewModel, ChangePasswordState>(
      'should emit [Loading, Error] when change password succeeds',
      build: () {
        changePasswordResponse = Failure<ChangePasswordResponse>(tErrorMessage);
        provideDummy<Result<ChangePasswordResponse>>(changePasswordResponse);

        when(
          mockChangePasswordUseCase.changePassword(
            changePasswordRequest: tRequest,
          ),
        ).thenAnswer((_) async => changePasswordResponse);

        return changePasswordViewModel;
      },
      act: (viewModel) => viewModel.doEvent(
        ChangePasswordIntent(changePasswordRequest: tRequest),
      ),
      expect: () => [
        isA<ChangePasswordState>().having(
          (s) => s.changePasswordState.requestState,
          'loading',
          RequestState.loading,
        ),

        isA<ChangePasswordState>().having(
          (s) => s.changePasswordState.requestState,
          'loaded',
          RequestState.error,
        ),
      ],
      verify: (_) {
        verify(
          mockChangePasswordUseCase.changePassword(
            changePasswordRequest: tRequest,
          ),
        ).called(1);
      },
    );
  });
  group("ChangePasswordViewModel Test cases for navigation and show toast", () {
    test(
      'should emit NavigateToEditProfileEvent when event is triggered',
      () async {
        // Arrange
        final events = <ChangePasswordEvents>[];
        changePasswordViewModel.uiEventsStream.listen(events.add);

        // Act
        changePasswordViewModel.doEvent(NavigateToEditProfileEvent());
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(events, hasLength(1));
        expect(events[0], isA<NavigateToEditProfileEvent>());
      },
    );
    test(
      'should emit show toast event when event is triggered success',
      () async {
        // Arrange
        final events = <ChangePasswordEvents>[];
        changePasswordViewModel.uiEventsStream.listen(events.add);

        // Act
        changePasswordViewModel.doEvent(
          ChangePasswordShowToastEvent(
            message: tSuccessMessage,
            isError: false,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(events, hasLength(1));
        expect(events[0], isA<ChangePasswordShowToastEvent>());
      },
    );
    test(
      'should emit show toast event when event is triggered failure',
      () async {
        // Arrange
        final events = <ChangePasswordEvents>[];
        changePasswordViewModel.uiEventsStream.listen(events.add);

        // Act
        changePasswordViewModel.doEvent(
          ChangePasswordShowToastEvent(message: tErrorMessage, isError: true),
        );
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(events, hasLength(1));
        expect(events[0], isA<ChangePasswordShowToastEvent>());
      },
    );
  });
}
