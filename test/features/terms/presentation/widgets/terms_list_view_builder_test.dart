import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';
import 'package:flower_app/features/terms/presentation/widgets/terms_item_widget.dart';
import 'package:flower_app/features/terms/presentation/widgets/terms_list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(List<TermsEntity> entity) => EasyLocalization(
    supportedLocales: const [Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: const Locale('en'),
    child: MaterialApp(
      theme: LightTheme().themeData,
      home: TermsListViewBuilder(entities: entity),
    ),
  );

  testWidgets("Test ListViewBuilder", (WidgetTester tester) async {
    var entity = TermsEntity(
      section: 'section',
      contentAr: ['محتوى'],
      contentEn: ['content'],
      fontSize: 16,
      colorHex: "0xFFFFFFFF",
      fontWeight: 'bold',
    );
    var entities = [entity, entity, entity];
    await tester.pumpWidget(buildTestableWidget(entities));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TermsItemWidget), findsNWidgets(entities.length));
    expect(find.byType(Text), findsNWidgets(entities.length));
    expect(find.byType(Container), findsNWidgets(entities.length));
    expect(find.byType(Column), findsNWidgets(entities.length));
  });
}
