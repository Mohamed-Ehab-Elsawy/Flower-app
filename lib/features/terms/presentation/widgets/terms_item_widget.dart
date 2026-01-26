import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';
import 'package:flutter/material.dart';

class TermsItemWidget extends StatelessWidget {
  final TermsEntity entity;
  final bool isArabic;

  const TermsItemWidget({
    super.key,
    required this.entity,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> contentList = isArabic
        ? entity.contentAr
        : entity.contentEn;

    final TextStyle dynamicStyle = TextStyle(
      fontSize: entity.fontSize,
      color: entity.colorHex.toColor,
      fontWeight: entity.fontWeight.toFontWeight,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: contentList
            .map(
              (text) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  text,
                  style: dynamicStyle,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  textDirection: isArabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
