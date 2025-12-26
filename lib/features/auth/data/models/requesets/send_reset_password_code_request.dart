import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_reset_password_code_request.g.dart';

@JsonSerializable()
class SendResetPasswordCodeRequest with EquatableMixin {
  @JsonKey(name: 'email')
  final String email;

  SendResetPasswordCodeRequest({required this.email});

  factory SendResetPasswordCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$SendResetPasswordCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendResetPasswordCodeRequestToJson(this);

  @override
  List<Object?> get props => [email];
}
