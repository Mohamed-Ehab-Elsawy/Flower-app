import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/terms/presentation/terms_widgets_keys.dart';
import 'package:flower_app/features/terms/presentation/widgets/terms_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget({
    required String message,
    VoidCallback? onRetry,
  }) => MaterialApp(
    theme: LightTheme().themeData,
    home: TermsErrorWidget(message: message),
  );

  testWidgets("Terms error widget init view", (WidgetTester tester) async {
    var message = "Error message";
    await tester.pumpWidget(buildTestableWidget(message: message));
    expect(find.byKey(const Key(TermsWidgetsKeys.retryButton)), findsOneWidget);
    expect(find.byKey(const Key(TermsWidgetsKeys.retryText)), findsOneWidget);
    expect(find.byKey(const Key(TermsWidgetsKeys.errorIcon)), findsOneWidget);
    expect(
      find.byKey(const Key(TermsWidgetsKeys.errorViewColumn)),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.errorMessageText)),
      findsOneWidget,
    );
    expect(find.byType(SizedBox), findsNWidgets(3));
    expect(find.text(message), findsOneWidget);
  });
}
