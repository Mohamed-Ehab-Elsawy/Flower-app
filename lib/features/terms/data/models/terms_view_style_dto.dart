import 'package:flower_app/features/terms/data/models/terms_view_text_align_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terms_view_style_dto.g.dart';

@JsonSerializable()
class TermsViewStyleDto {
  @JsonKey(name: "fontSize")
  final int? fontSize;
  @JsonKey(name: "fontWeight")
  final String? fontWeight;
  @JsonKey(name: "color")
  final String? color;
  @JsonKey(name: "textAlign")
  final TermsViewTextAlignDto? textAlign;
  @JsonKey(name: "backgroundColor")
  final String? backgroundColor;

  TermsViewStyleDto({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });

  factory TermsViewStyleDto.fromJson(Map<String, dynamic> json) =>
      _$TermsViewStyleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TermsViewStyleDtoToJson(this);
}
