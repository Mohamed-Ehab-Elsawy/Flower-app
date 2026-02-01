import 'package:flower_app/features/terms/data/models/content_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terms_view_content_dto.g.dart';

@JsonSerializable()
class TermsViewContentDto {
  @JsonKey(name: "en")
  @ContentConverter()
  final List<String>? en;

  @JsonKey(name: "ar")
  @ContentConverter()
  final List<String>? ar;

  TermsViewContentDto({this.en, this.ar});

  factory TermsViewContentDto.fromJson(Map<String, dynamic> json) =>
      _$TermsViewContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TermsViewContentDtoToJson(this);
}
