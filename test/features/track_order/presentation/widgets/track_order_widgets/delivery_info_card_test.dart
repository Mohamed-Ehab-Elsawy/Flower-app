import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/widgets/track_order_widgets/delivery_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget build({VoidCallback? onCallTap, VoidCallback? onMessageTap}) {
    return MaterialApp(
      theme: LightTheme().themeData,
      home: Scaffold(
        body: DeliveryInfoCard(
          order: const ActiveOrderEntity(
            orderId: 'order_1',
            documentExists: true,
            userName: 'Mona',
            userImage: 'assets/image/user.png',
            userAddress: 'Nasr City',
          ),
          onCallTap: onCallTap,
          onMessageTap: onMessageTap,
        ),
      ),
    );
  }

  testWidgets('renders user name and action icons', (tester) async {
    await tester.pumpWidget(build());
    await tester.pump();

    expect(find.byType(DeliveryInfoCard), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byIcon(Icons.phone_outlined), findsOneWidget);
    expect(find.byIcon(Icons.chat_outlined), findsOneWidget);
  });

  testWidgets('fires call and message callbacks', (tester) async {
    var callTapped = false;
    var messageTapped = false;

    await tester.pumpWidget(
      build(
        onCallTap: () => callTapped = true,
        onMessageTap: () => messageTapped = true,
      ),
    );
    await tester.pump();

    await tester.tap(find.byIcon(Icons.phone_outlined));
    await tester.tap(find.byIcon(Icons.chat_outlined));
    await tester.pump();

    expect(callTapped, true);
    expect(messageTapped, true);
  });
}
