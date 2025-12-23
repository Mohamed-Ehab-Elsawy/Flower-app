import 'package:json_annotation/json_annotation.dart';

part 'send_reset_password_code_request.g.dart';

@JsonSerializable()
class SendResetPasswordCodeRequest {
  @JsonKey(name: 'email')
  final String email;

  SendResetPasswordCodeRequest({required this.email});

  factory SendResetPasswordCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$SendResetPasswordCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendResetPasswordCodeRequestToJson(this);
}
