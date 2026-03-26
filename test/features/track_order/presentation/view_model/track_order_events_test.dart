import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TrackOrder Intents Tests', () {
    test('ListenToOrderIntent should hold orderId', () {
      final intent = ListenToOrderIntent('order_123');
      expect(intent.orderId, 'order_123');
    });

    test('ShowMapIntent type should be correct', () {
      final intent = ShowMapIntent();
      expect(intent, isA<ShowMapIntent>());
    });

    test('ShowOrderDetailsIntent type should be correct', () {
      final intent = ShowOrderDetailsIntent();
      expect(intent, isA<ShowOrderDetailsIntent>());
    });

    test('OrderDeliveredIntent should hold order entity', () {
      const order = ActiveOrderEntity(orderId: 'order_1', documentExists: true);
      final intent = OrderDeliveredIntent(order);
      expect(intent.order, order);
    });

    test('CallDeliveryIntent should hold phone number', () {
      final intent = CallDeliveryIntent('+201001112233');
      expect(intent.phone, '+201001112233');
    });

    test('MessageDeliveryIntent should hold phone and message', () {
      final intent = MessageDeliveryIntent('+201001112233', message: 'hello');
      expect(intent.phone, '+201001112233');
      expect(intent.message, 'hello');
    });
  });

  group('TrackOrder UI Events Tests', () {
    test('NavigatePopScreen type should be correct', () {
      final event = NavigatePopScreen();
      expect(event, isA<NavigatePopScreen>());
    });

    test('LaunchExternalUrl should hold uri', () {
      final uri = Uri.parse('tel:+201001112233');
      final event = LaunchExternalUrl(uri);
      expect(event.uri, uri);
    });
  });
}
