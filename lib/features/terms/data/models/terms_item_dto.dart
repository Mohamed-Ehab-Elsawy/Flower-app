import 'package:flower_app/features/terms/data/models/terms_view_style_dto.dart';
import 'package:flower_app/features/terms/data/models/terms_view_content_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terms_item_dto.g.dart';

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
