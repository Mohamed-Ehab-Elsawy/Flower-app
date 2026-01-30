import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/profile/domain/entity/about_section_entity.dart';
import 'package:flutter/material.dart';

class AboutSectionWidget extends StatelessWidget {
  final AboutSectionEntity section;

  const AboutSectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final langCode = context.locale.languageCode;
    final isAr = langCode == 'ar';

    final List<String> contentList = section.content.getByLanguage(langCode);
    final List<String> titleList = section.title?.getByLanguage(langCode) ?? [];

    final String? rawTitle = titleList.isNotEmpty ? titleList.first : null;
    final List<String> paragraphs = contentList;

    final styleMap = section.style;

    final contentStyle = styleMap['content'] is Map
        ? styleMap['content'] as Map
        : styleMap;
    final titleStyle = styleMap['title'] is Map
        ? styleMap['title'] as Map
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (rawTitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                rawTitle,
                textAlign: _parseTextAlign(
                  titleStyle?['textAlign'] ?? styleMap['textAlign'],
                  langCode,
                ),
                style: TextStyle(
                  fontSize: (titleStyle?['fontSize'] as num?)?.toDouble() ?? 20,
                  fontWeight: FontWeight.bold,
                  color:
                      _parseColor(titleStyle?['color'] ?? styleMap['color']) ??
                      Theme.of(context).colorScheme.primary,
                  height: 1.3,
                ),
              ),
            ),

          if (paragraphs.isNotEmpty) ...[
            if (paragraphs.length == 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildParagraph(
                  paragraphs.first,
                  contentStyle,
                  langCode,
                  isAr,
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: paragraphs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final text = entry.value;
                  final isLast = index == paragraphs.length - 1;

                  return Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                    child: _buildListItem(text, contentStyle, isAr, langCode),
                  );
                }).toList(),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildParagraph(String text, Map style, String lang, bool isAr) {
    return Text(
      text,
      textAlign: _parseTextAlign(style['textAlign'], lang),
      style: TextStyle(
        fontSize: (style['fontSize'] as num?)?.toDouble() ?? 16,
        color: _parseColor(style['color']) ?? Colors.black87,
        height: 1.6,
      ),
    );
  }

  Widget _buildListItem(String text, Map style, bool isAr, String lang) {
    final double fontSize = (style['fontSize'] as num?)?.toDouble() ?? 16;
    final Color textColor = _parseColor(style['color']) ?? Colors.black87;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: _buildBullet(textColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            textAlign: _parseTextAlign(style['textAlign'], lang),
            style: TextStyle(fontSize: fontSize, color: textColor, height: 1.6),
          ),
        ),
      ],
    );
  }

  Widget _buildBullet(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Color? _parseColor(dynamic value) {
    if (value == null || value is! String || value.isEmpty) return null;
    String hex = value.replaceFirst('#', '');
    if (hex.length == 6) hex = 'ff$hex';
    try {
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return null;
    }
  }

  TextAlign _parseTextAlign(dynamic alignMap, String lang) {
    if (alignMap is! Map) return TextAlign.start;
    final align = alignMap[lang]?.toString().toLowerCase();
    return switch (align) {
      'center' => TextAlign.center,
      'right' => TextAlign.right,
      'left' => TextAlign.left,
      _ => TextAlign.start,
    };
  }
}
