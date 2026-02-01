import 'package:json_annotation/json_annotation.dart';

part 'terms_view_text_align_dto.g.dart';

@JsonSerializable()
class TermsViewTextAlignDto {
  @JsonKey(name: "en")
  final String? en;
  @JsonKey(name: "ar")
  final String? ar;

  TermsViewTextAlignDto({this.en, this.ar});

  factory TermsViewTextAlignDto.fromJson(Map<String, dynamic> json) =>
      _$TermsViewTextAlignDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TermsViewTextAlignDtoToJson(this);
}
