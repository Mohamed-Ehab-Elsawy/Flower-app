import 'package:json_annotation/json_annotation.dart';

import 'content_converter.dart';

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

@JsonSerializable()
class TermsItemDto {
  @JsonKey(name: "section")
  final String? section;
  @JsonKey(name: "content")
  final TermsViewContentDto? content;
  @JsonKey(name: "style")
  final TermsViewStyleDto? style;

  TermsItemDto({this.section, this.content, this.style});

  factory TermsItemDto.fromJson(Map<String, dynamic> json) =>
      _$TermsItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TermsItemDtoToJson(this);
}

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
