import 'package:flower_app/features/profile/data/models/about_us_dto.dart';
import 'package:flower_app/features/profile/domain/entity/about_section_entity.dart';
import 'package:flower_app/features/profile/domain/entity/about_us_entity.dart';
import 'package:flower_app/features/profile/domain/entity/localized_content_entity.dart';

extension AboutUsMapper on AboutUsDto {
  AboutUsEntity toEntity() {
    return AboutUsEntity(
      sections:
          aboutApp?.map((sectionDto) => sectionDto.toEntity()).toList() ?? [],
    );
  }
}

extension AboutAppMapper on AboutApp {
  AboutSectionEntity toEntity() {
    return AboutSectionEntity(
      sectionName: section ?? '',
      content: LocalizedContent(en: content?.en, ar: content?.ar),
      style: {
        'fontSize': style?.fontSize,
        'fontWeight': style?.fontWeight,
        'color': style?.color,
        'backgroundColor': style?.backgroundColor,
        'textAlign': {'en': style?.textAlign?.en, 'ar': style?.textAlign?.ar},
      },
    );
  }
}
