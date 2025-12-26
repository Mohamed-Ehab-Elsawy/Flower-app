import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? userDto;
  @JsonKey(name: "token")
  final String? token;

  LoginResponseDto ({
    this.message,
    this.userDto,
    this.token,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) => _$LoginResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);
}




