import 'package:flower_app/features/terms/data/models/terms_item_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terms_response_dto.g.dart';

@JsonSerializable()
class TermsResponseDTO {
  @JsonKey(name: "terms_and_conditions")
  final List<TermsItemDto>? terms;

  TermsResponseDTO({this.terms});

  factory TermsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$TermsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TermsResponseDTOToJson(this);
}
