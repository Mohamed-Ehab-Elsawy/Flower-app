import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ActiveOrderEntity', () {
    test('parses fireStore payload and coordinates correctly', () {
      final entity = ActiveOrderEntity.fromFirestore({
        'driverId': 'driver_1',
        'userId': 'user_1',
        'status': 'out_for_delivery',
        'lat': 30.123,
        'long': 31.456,
        'storeLatLong': '30.111,31.222',
        'startedAt': Timestamp.fromDate(DateTime(2026, 3, 26)),
      }, 'order_1');

      expect(entity.orderId, 'order_1');
      expect(entity.documentExists, true);
      expect(entity.hasDriverPosition, true);
      expect(entity.latDouble, 30.123);
      expect(entity.longDouble, 31.456);
      expect(entity.hasUserPosition, true);
      expect(entity.userLatDouble, 30.111);
      expect(entity.userLngDouble, 31.222);
    });

    test('phone getter prefers store phone over user phone', () {
      const entity = ActiveOrderEntity(
        documentExists: true,
        storePhoneNumber: '111',
        userPhoneNumber: '222',
      );
      expect(entity.phone, '111');
    });
  });
}
