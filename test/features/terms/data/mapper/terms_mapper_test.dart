import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/terms/data/models/terms_response_dto.dart';
import 'package:flower_app/features/terms/data/models/terms_item_dto.dart';
import 'package:flower_app/features/terms/data/models/terms_view_content_dto.dart';
import 'package:flower_app/features/terms/data/models/terms_view_style_dto.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';
import 'package:flower_app/features/terms/data/mapper/terms_mapper.dart';

void main() {
  group('TermsMapper Extension Tests', () {
    test('should map TermsResponseDTO to List<TermsEntity> correctly', () {
      // Arrange
      final dto = TermsResponseDTO(
        terms: [
          TermsItemDto(
            section: "Privacy",
            content: TermsViewContentDto(
              en: ["Line 1", "Line 2"],
              ar: ["سطر 1"],
            ),
            style: TermsViewStyleDto(
              fontSize: 18,
              color: "#FFFFFF",
              fontWeight: "bold",
            ),
          ),
        ],
      );

      // Act
      final result = dto.toEntity();

      // Assert
      expect(result.length, 1);
      expect(result.first.section, "Privacy");
      expect(result.first.contentEn, ["Line 1", "Line 2"]);
      expect(result.first.fontSize, 18.0);
      expect(result.first.colorHex, "#FFFFFF");
      expect(result.first.fontWeight, "bold");
    });

    test('should return default values when DTO fields are null', () {
      // Arrange
      final dto = TermsResponseDTO(
        terms: [TermsItemDto(section: null, content: null, style: null)],
      );

      // Act
      final result = dto.toEntity();

      // Assert
      final entity = result.first;
      expect(entity.section, "");
      expect(entity.contentEn, []);
      expect(entity.fontSize, 14.0);
      expect(entity.colorHex, "#000000");
      expect(entity.fontWeight, "normal");
    });

    test('should return empty list when terms list in DTO is null', () {
      // Arrange
      final dto = TermsResponseDTO(terms: null);

      // Act
      final result = dto.toEntity();

      // Assert
      expect(result, isA<List<TermsEntity>>());
      expect(result, isEmpty);
    });

    test(
      'should handle content as dynamic types (String vs List) via _parseContent',
      () {
        final dto = TermsResponseDTO(
          terms: [
            TermsItemDto(
              section: "Dynamic Test",
              content: TermsViewContentDto(en: ["List Item"], ar: null),
            ),
          ],
        );

        final result = dto.toEntity();

        expect(result.first.contentEn, ["List Item"]);
        expect(result.first.contentAr, []);
      },
    );
  });
}
