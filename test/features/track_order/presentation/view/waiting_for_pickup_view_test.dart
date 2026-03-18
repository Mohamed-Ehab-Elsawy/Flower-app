import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/track_order/presentation/view/waiting_for_pickup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

void main() {
  Widget buildTestableWidget({String orderId = 'order_123'}) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        theme: LightTheme().themeData,
        home: WaitingForPickupView(orderId: orderId),
      ),
    );
  }

  group('WaitingForPickupView Widget Test', () {
    testWidgets('Initial UI renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Track Order'), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
      expect(find.byIcon(Icons.schedule), findsOneWidget);
      expect(find.byType(Container), findsAtLeastNWidgets(1));
    });

    testWidgets('Body has correct structure with Padding and Column', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(Padding), findsAtLeastNWidgets(1));
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('Renders all expected Text widgets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(Text), findsNWidgets(4));
    });

    testWidgets('Info container with schedule icon is displayed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      final containerFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration! as BoxDecoration).color ==
                const Color(0xFFFFF3E0),
      );
      expect(containerFinder, findsOneWidget);

      expect(find.byIcon(Icons.schedule), findsOneWidget);
    });

    testWidgets('Lottie animation widget has correct dimensions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      final lottieFinder = find.byType(Lottie);
      expect(lottieFinder, findsOneWidget);

      final Lottie lottieWidget = tester.widget(lottieFinder);
      expect(lottieWidget.width, 200);
      expect(lottieWidget.height, 200);
    });

    testWidgets('Renders with different orderId', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(orderId: 'order_456'));
      await tester.pump();

      expect(find.byType(WaitingForPickupView), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('Track Order'), findsOneWidget);
    });

    testWidgets('AppBar title is visible', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.text('Track Order'), findsOneWidget);
    });

    testWidgets('No loading indicator in initial state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
