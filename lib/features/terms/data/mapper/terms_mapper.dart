import 'package:flower_app/features/terms/data/models/terms_response_dto.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';

extension TermsMapper on TermsResponseDTO {
  List<TermsEntity> toEntity() {
    var termItems = terms?.map((item) => _mapItemToEntity(item)).toList() ?? [];
    return termItems;
  }

  TermsEntity _mapItemToEntity(TermsItemDto item) => TermsEntity(
    section: item.section ?? '',
    contentEn: _parseContent(item.content?.en),
    contentAr: _parseContent(item.content?.ar),
    fontSize: item.style?.fontSize?.toDouble() ?? 14.0,
    colorHex: item.style?.color ?? "#000000",
    fontWeight: item.style?.fontWeight ?? "normal",
  );

  List<String> _parseContent(dynamic raw) {
    if (raw == null) return [];
    if (raw is String) return [raw];
    if (raw is List) return List<String>.from(raw);
    return [];
  }
}
