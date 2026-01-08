
import 'package:json_annotation/json_annotation.dart';
part 'base_response_result_dto.g.dart';
@JsonSerializable()
class SuccessResponseDto{
  @JsonKey(name: "message")
  final String ? message;

  SuccessResponseDto(this.message);
  factory SuccessResponseDto.fromJson(Map<String,dynamic>json)=>
      _$SuccessResponseDtoFromJson(json);

}


@JsonSerializable()
class FailureResponseDto{
  @JsonKey(name: "error")
  final String ? error;

  FailureResponseDto(this.error);
  factory FailureResponseDto.fromJson(Map<String,dynamic>json)=>
      _$FailureResponseDtoFromJson(json);

}