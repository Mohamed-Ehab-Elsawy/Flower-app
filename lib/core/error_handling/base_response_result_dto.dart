import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response_result_dto.g.dart';

@JsonSerializable()
class SuccessResponseDto extends Equatable {
  @JsonKey(name: "message")
  final String? message;

  const SuccessResponseDto({this.message});

  factory SuccessResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseDtoFromJson(json);

  @override
  List<Object?> get props => [message];
}

@JsonSerializable()
class FailureResponseDto extends Equatable {
  @JsonKey(name: "error")
  final String? error;

  const FailureResponseDto({this.error});

  factory FailureResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FailureResponseDtoFromJson(json);

  @override
  List<Object?> get props => [error];
}
