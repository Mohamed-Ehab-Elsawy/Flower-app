import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'login_view_model_test.mocks.dart';
@GenerateMocks([LoginUseCase])


void main() {
  final String email = "test@gmail.com";
  final String password = "123456";
  late MockLoginUseCase loginUseCase ;
  late  LoginViewModel viewModel ;
  setUpAll(() {
    loginUseCase = MockLoginUseCase();
  });
  setUp(() {
    viewModel = LoginViewModel(loginUseCase);
  });

  blocTest(
    "when call doIntent ",
    build: () => viewModel,
    act: (bloc) => viewModel.doIntent(Login(email: email, password: password)),
  );


  // test("when call doIntent ", () {
  //
  //   // Arrange
  //
  //
  //   // Act
  //
  //
  //   // Assertion And Verification
  //
  //
  //
  //
  // });
}