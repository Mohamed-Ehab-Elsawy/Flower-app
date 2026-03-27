import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/domain/repo/track_order_repo.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_view_model_test.mocks.dart';

@GenerateMocks([TrackOrderRepo])
void main() {
  late MockTrackOrderRepo mockTrackOrderRepo;
  late TrackOrderViewModel viewModel;

  setUp(() {
    mockTrackOrderRepo = MockTrackOrderRepo();
    viewModel = TrackOrderViewModel(mockTrackOrderRepo);
  });

  tearDown(() async {
    await viewModel.close();
  });

  group('TrackOrderViewModel state', () {
    blocTest<TrackOrderViewModel, TrackOrderStates>(
      'ShowMapIntent emits showMap=true',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ShowMapIntent()),
      expect: () => [TrackOrderStates.initial().copyWith(showMap: true)],
    );

    blocTest<TrackOrderViewModel, TrackOrderStates>(
      'ShowOrderDetailsIntent emits showMap=false',
      build: () => viewModel,
      seed: () => TrackOrderStates.initial().copyWith(showMap: true),
      act: (bloc) => bloc.doIntent(ShowOrderDetailsIntent()),
      expect: () => [TrackOrderStates.initial().copyWith(showMap: false)],
    );

    blocTest<TrackOrderViewModel, TrackOrderStates>(
      'ListenToOrderIntent emits loading then loaded on success stream',
      build: () => viewModel,
      setUp: () {
        when(
          mockTrackOrderRepo.listenToOrder(orderId: 'order_1'),
        ).thenAnswer((_) => Stream.value(Success(_order())));
      },
      act: (bloc) => bloc.doIntent(ListenToOrderIntent('order_1')),
      expect: () => [
        TrackOrderStates.initial().copyWith(
          orderState: const BaseState(requestState: RequestState.loading),
        ),
        TrackOrderStates.initial().copyWith(
          orderState: BaseState.loaded(_order()),
        ),
      ],
    );

    blocTest<TrackOrderViewModel, TrackOrderStates>(
      'ListenToOrderIntent emits loading then error on failure stream',
      build: () => viewModel,
      setUp: () {
        when(
          mockTrackOrderRepo.listenToOrder(orderId: 'order_1'),
        ).thenAnswer((_) => Stream.value(Failure<ActiveOrderEntity>('failed')));
      },
      act: (bloc) => bloc.doIntent(ListenToOrderIntent('order_1')),
      expect: () => [
        TrackOrderStates.initial().copyWith(
          orderState: const BaseState(requestState: RequestState.loading),
        ),
        TrackOrderStates.initial().copyWith(
          orderState: BaseState.error('failed'),
        ),
      ],
    );
  });

  group('TrackOrderViewModel ui events', () {
    test('CallDeliveryIntent emits tel URI when phone exists', () async {
      final emitted = <TrackOrderUIEvents>[];
      final sub = viewModel.uiEventsStream.listen(emitted.add);

      viewModel.doIntent(CallDeliveryIntent('+20 100 200 300'));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(emitted.single, isA<LaunchExternalUrl>());
      final event = emitted.single as LaunchExternalUrl;
      expect(event.uri.toString(), 'tel:+20100200300');
      await sub.cancel();
    });

    test(
      'MessageDeliveryIntent emits wa.me URI with encoded message',
      () async {
        final emitted = <TrackOrderUIEvents>[];
        final sub = viewModel.uiEventsStream.listen(emitted.add);

        viewModel.doIntent(
          MessageDeliveryIntent('+20 100 200 300', message: 'hello driver'),
        );
        await Future<void>.delayed(const Duration(milliseconds: 10));

        expect(emitted.single, isA<LaunchExternalUrl>());
        final event = emitted.single as LaunchExternalUrl;
        expect(
          event.uri.toString(),
          'https://wa.me/20100200300?text=hello%20driver',
        );
        await sub.cancel();
      },
    );

    test(
      'OrderDeliveredIntent sends notification then emits pop event',
      () async {
        final order = _order(driverToken: 'token_1');
        when(
          mockTrackOrderRepo.sendOrderDeliveredNotification(order),
        ).thenAnswer((_) async {});
        final emitted = <TrackOrderUIEvents>[];
        final sub = viewModel.uiEventsStream.listen(emitted.add);

        viewModel.doIntent(OrderDeliveredIntent(order));
        await Future<void>.delayed(const Duration(milliseconds: 20));

        verify(
          mockTrackOrderRepo.sendOrderDeliveredNotification(order),
        ).called(1);
        expect(emitted.single, isA<NavigatePopScreen>());
        await sub.cancel();
      },
    );
  });
}

ActiveOrderEntity _order({String driverToken = ''}) {
  return ActiveOrderEntity(
    orderId: 'order_1',
    driverId: 'driver_1',
    userId: 'user_1',
    userName: 'Ahmed',
    userImage: 'assets/image/user.png',
    userAddress: 'Nasr City',
    driverToken: driverToken,
    status: 'picked',
    lat: '30.1',
    long: '31.2',
    storeLatLong: '30.05,31.25',
    documentExists: true,
  );
}
