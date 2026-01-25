import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_user_data_response_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDataResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? user;

  GetCurrentUserDataResponseDto({this.message, this.user});

  factory GetCurrentUserDataResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDataResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentUserDataResponseDtoToJson(this);
}
