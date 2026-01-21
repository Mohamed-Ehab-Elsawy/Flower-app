import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "firstName")
  final String firstName;
  @JsonKey(name: "lastName")
  final String lastName;
  const EditProfileRequest ({required this.email, required this.phone, required this.firstName, required this.lastName});

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) => _$EditProfileRequestFromJson(json);

  Map<String, dynamic> toJson() =>_$EditProfileRequestToJson(this);
}


