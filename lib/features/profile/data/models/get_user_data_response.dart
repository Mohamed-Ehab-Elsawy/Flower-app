import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_user_data_response.g.dart';

@JsonSerializable()
class GetUserDataResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? user;


  const GetUserDataResponse ({this.message,this.user});

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) => _$GetUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>_$GetUserDataResponseToJson(this);
}


