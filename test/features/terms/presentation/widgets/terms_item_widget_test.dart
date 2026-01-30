import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';
import 'package:flower_app/features/terms/presentation/widgets/terms_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(TermsEntity entity, bool isArabic) => MaterialApp(
    theme: LightTheme().themeData,
    home: TermsItemWidget(entity: entity, isArabic: isArabic),
  );

  testWidgets("Test content when locale is EN", (WidgetTester tester) async {
    var entity = TermsEntity(
      section: 'section',
      contentAr: [],
      contentEn: ['content', 'content', 'content', 'content'],
      fontSize: 16,
      colorHex: "0xFFFFFFFF",
      fontWeight: 'bold',
    );
    await tester.pumpWidget(buildTestableWidget(entity, false));

    expect(find.byType(Padding), findsNWidgets(entity.contentEn.length + 1));
    expect(find.byType(Text), findsNWidgets(entity.contentEn.length));
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
  });

  testWidgets("Test content when locale is EN", (WidgetTester tester) async {
    var entity = TermsEntity(
      section: 'section',
      contentAr: ['محتوى', 'محتوى', 'محتوى', 'محتوى'],
      contentEn: [],
      fontSize: 16,
      colorHex: "0xFFFFFFFF",
      fontWeight: 'bold',
    );
    await tester.pumpWidget(buildTestableWidget(entity, true));

    expect(find.byType(Padding), findsNWidgets(entity.contentAr.length + 1));
    expect(find.byType(Text), findsNWidgets(entity.contentAr.length));
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
  });
}
