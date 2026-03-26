import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view/order_tracking_view.dart';
import 'package:flower_app/features/track_order/presentation/view/track_order_view.dart';
import 'package:flower_app/features/track_order/presentation/view/waiting_for_pickup_view.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_view_test.mocks.dart';

@GenerateMocks([TrackOrderViewModel])

void main() {
  late MockTrackOrderViewModel mockTrackOrderViewModel;

  setUp(() {
    mockTrackOrderViewModel = MockTrackOrderViewModel();
    when(mockTrackOrderViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockTrackOrderViewModel.uiEventsStream).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(mockTrackOrderViewModel.doIntent(any)).thenReturn(null);
  });

  Widget build() {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        theme: LightTheme().themeData,
        home: BlocProvider<TrackOrderViewModel>.value(
          value: mockTrackOrderViewModel,
          child: const TrackOrderView(orderId: 'order_1'),
        ),
      ),
    );
  }

  testWidgets('shows loader when order state is loading', (tester) async {
    when(mockTrackOrderViewModel.state).thenReturn(
      const TrackOrderStates(
        orderState: BaseState<ActiveOrderEntity>(
          requestState: RequestState.loading,
        ),
      ),
    );
    await tester.pumpWidget(build());
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows waiting view when document does not exist', (tester) async {
    when(mockTrackOrderViewModel.state).thenReturn(
      TrackOrderStates(
        orderState: BaseState.loaded(
          const ActiveOrderEntity(documentExists: false, orderId: 'order_1'),
        ),
      ),
    );
    await tester.pumpWidget(build());
    await tester.pump();
    expect(find.byType(WaitingForPickupView), findsOneWidget);
  });

  testWidgets('shows tracking screen when active order exists', (tester) async {
    when(mockTrackOrderViewModel.state).thenReturn(
      TrackOrderStates(orderState: BaseState.loaded(_activeOrder())),
    );
    await tester.pumpWidget(build());
    await tester.pump();
    expect(find.byType(OrderTrackingScreen), findsOneWidget);
  });

  testWidgets('calls ListenToOrderIntent after first frame', (tester) async {
    when(mockTrackOrderViewModel.state).thenReturn(
      TrackOrderStates(orderState: BaseState.loaded(_activeOrder())),
    );
    await tester.pumpWidget(build());
    await tester.pump();
    verify(
      mockTrackOrderViewModel.doIntent(argThat(isA<ListenToOrderIntent>())),
    ).called(1);
  });
}

ActiveOrderEntity _activeOrder() {
  return const ActiveOrderEntity(
    documentExists: true,
    orderId: 'order_1',
    userName: 'Mona',
    userImage: 'assets/image/user.png',
    userAddress: 'Nasr City',
    status: 'picked',
  );
}
