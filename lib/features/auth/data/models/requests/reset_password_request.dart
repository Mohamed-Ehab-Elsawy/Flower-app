import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest with EquatableMixin {
  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'newPassword')
  final String? password;

  ResetPasswordRequest({required this.email, required this.password});

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);

  @override
  List<Object?> get props => [email, password];
}
