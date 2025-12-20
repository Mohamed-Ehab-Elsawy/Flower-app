import 'package:json_annotation/json_annotation.dart';

part 'send_reset_password_code_response.g.dart';

@JsonSerializable()
class SendResetPasswordCodeResponse {
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'info')
  final String info;

  SendResetPasswordCodeResponse({required this.message, required this.info});

  factory SendResetPasswordCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SendResetPasswordCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendResetPasswordCodeResponseToJson(this);
}
