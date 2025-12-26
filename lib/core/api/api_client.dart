import 'package:dio/dio.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:retrofit/retrofit.dart';

import 'end_points.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(EndPoints.forgetPassword)
  Future<SendResetPasswordCodeResponse> sendResetPasswordCode({
    @Body() required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  });

  @POST(EndPoints.verifyResetCode)
  Future<VerifyResetCodeResponse> verifyResetPasswordCode({
    @Body() required VerifyResetCodeRequest verifyResetCodeRequest,
  });

  @PUT(EndPoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword({
    @Body() required ResetPasswordRequest resetPasswordRequest,
  });
}
