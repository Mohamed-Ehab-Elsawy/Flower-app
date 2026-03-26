import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/send_notification_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/track_order/data/data_source/track_order_data_source_impl.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'track_order_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeFirebaseFirestore firestore;
  late MockApiClient apiClient;
  late TrackOrderDataSourceImpl dataSource;

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
          (call) async {
            if (call.method == 'read') return 'mock_fcm_token';
            return null;
          },
        );
  });

  setUp(() {
    firestore = FakeFirebaseFirestore();
    apiClient = MockApiClient();
    dataSource = TrackOrderDataSourceImpl(firestore, apiClient);
  });

  group('TrackOrderDataSourceImpl.listenToOrder', () {
    test('emits loaded entity when order document exists', () async {
      await firestore.collection('active_orders').doc('order_1').set({
        'driverId': 'driver_1',
        'userId': 'user_1',
        'status': 'picked',
        'lat': '30.1',
        'long': '31.2',
        'storeLatLong': '30.05,31.25',
      });

      final result = await dataSource.listenToOrder(orderId: 'order_1').first;

      expect(result, isA<Success<ActiveOrderEntity>>());
      final data = (result as Success<ActiveOrderEntity>).data;
      expect(data.documentExists, true);
      expect(data.orderId, 'order_1');
      expect(data.driverId, 'driver_1');
      expect(data.userId, 'user_1');
      expect(data.hasDriverPosition, true);
      expect(data.hasUserPosition, true);
    });

    test('emits documentExists=false when order document missing', () async {
      final result = await dataSource.listenToOrder(orderId: 'order_1').first;

      expect(result, isA<Success<ActiveOrderEntity>>());
      final data = (result as Success<ActiveOrderEntity>).data;
      expect(data.documentExists, false);
      expect(data.orderId, 'order_1');
    });
  });

  group('TrackOrderDataSourceImpl.sendOrderDeliveredNotification', () {
    test('returns Success when API call succeeds', () async {
      when(
        apiClient.sendNotification(
          notificationDto: argThat(
            isA<SendNotificationRequest>(),
            named: 'notificationDto',
          ),
          authorization: 'Bearer mock_fcm_token',
        ),
      ).thenAnswer((_) async {});

      final result = await dataSource.sendOrderDeliveredNotification(
        targetToken: 'driver_token',
        title: 'Order Delivered',
        body: 'Customer confirmed delivery',
      );

      expect(result, isA<Success<void>>());
      verify(
        apiClient.sendNotification(
          notificationDto: argThat(
            isA<SendNotificationRequest>(),
            named: 'notificationDto',
          ),
          authorization: 'Bearer mock_fcm_token',
        ),
      ).called(1);
      verifyNoMoreInteractions(apiClient);
    });

    test('returns Failure when API call throws exception', () async {
      when(
        apiClient.sendNotification(
          notificationDto: argThat(
            isA<SendNotificationRequest>(),
            named: 'notificationDto',
          ),
          authorization: 'Bearer mock_fcm_token',
        ),
      ).thenThrow(Exception('network error'));

      final result = await dataSource.sendOrderDeliveredNotification(
        targetToken: 'driver_token',
        title: 'Order Delivered',
        body: 'Customer confirmed delivery',
      );

      expect(result, isA<Failure<void>>());
      verify(
        apiClient.sendNotification(
          notificationDto: argThat(
            isA<SendNotificationRequest>(),
            named: 'notificationDto',
          ),
          authorization: 'Bearer mock_fcm_token',
        ),
      ).called(1);
      verifyNoMoreInteractions(apiClient);
    });
  });
}
