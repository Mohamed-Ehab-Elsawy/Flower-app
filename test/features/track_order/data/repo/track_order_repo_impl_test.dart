import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/track_order/data/data_source/track_order_data_source.dart';
import 'package:flower_app/features/track_order/data/repo/track_order_repo_impl.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_repo_impl_test.mocks.dart';

@GenerateMocks([TrackOrderDataSource])
void main() {
  late MockTrackOrderDataSource mockTrackOrderDataSource;
  late TrackOrderRepoImpl repo;

  setUp(() {
    mockTrackOrderDataSource = MockTrackOrderDataSource();
    repo = TrackOrderRepoImpl(mockTrackOrderDataSource);
  });

  group("TrackOrderRepoImpl.listenToOrder", () {
    test("Should return stream from data source", () async {
      const entity = ActiveOrderEntity(
        orderId: 'order_1',
        documentExists: true,
      );
      when(
        mockTrackOrderDataSource.listenToOrder(orderId: 'order_1'),
      ).thenAnswer((_) => Stream.value(Success(entity)));

      final result = await repo.listenToOrder(orderId: 'order_1').first;

      expect(result, Success(entity));
      verify(
        mockTrackOrderDataSource.listenToOrder(orderId: 'order_1'),
      ).called(1);
      verifyNoMoreInteractions(mockTrackOrderDataSource);
    });
  });

  group("TrackOrderRepoImpl.sendOrderDeliveredNotification", () {
    const order = ActiveOrderEntity(
      documentExists: true,
      driverToken: 'driver_token',
    );

    test("Should return Success when data source succeeds", () async {
      provideDummy<Result<void>>(Success<void>(null));
      when(
        mockTrackOrderDataSource.sendOrderDeliveredNotification(
          targetToken: 'driver_token',
          title: 'Order Delivered',
          body: 'Customer confirmed delivery',
        ),
      ).thenAnswer((_) async => Success<void>(null));

      final result = await repo.sendOrderDeliveredNotification(order);

      expect(result, isA<Success<void>>());
      verify(
        mockTrackOrderDataSource.sendOrderDeliveredNotification(
          targetToken: 'driver_token',
          title: 'Order Delivered',
          body: 'Customer confirmed delivery',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockTrackOrderDataSource);
    });

    test("Should return Failure when data source fails", () async {
      provideDummy<Result<void>>(Failure<void>('notification failed'));
      when(
        mockTrackOrderDataSource.sendOrderDeliveredNotification(
          targetToken: 'driver_token',
          title: 'Order Delivered',
          body: 'Customer confirmed delivery',
        ),
      ).thenAnswer((_) async => Failure<void>('notification failed'));

      final result = await repo.sendOrderDeliveredNotification(order);

      expect(result, isA<Failure<void>>());
      expect((result as Failure<void>).errorMessage, 'notification failed');
      verify(
        mockTrackOrderDataSource.sendOrderDeliveredNotification(
          targetToken: 'driver_token',
          title: 'Order Delivered',
          body: 'Customer confirmed delivery',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockTrackOrderDataSource);
    });
  });
}
