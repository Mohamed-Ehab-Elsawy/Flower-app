import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'constants/end_points.dart';
import 'models/requests/user_request.dart';
import 'models/response/signup_response.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;
  @POST(EndPoints.signUpEndpoint)
  Future<SignupResponse> signUp(@Body() UserRequest userRequest);
}
