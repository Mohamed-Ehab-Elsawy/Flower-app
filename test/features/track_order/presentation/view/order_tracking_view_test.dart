import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view/order_tracking_view.dart';
import 'package:flower_app/features/track_order/presentation/widgets/order_tracking/details_view.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_tracking_view_test.mocks.dart';

@GenerateMocks([TrackOrderViewModel])
void main() {
  late MockTrackOrderViewModel mockTrackOrderViewModel;

  setUp(() {
    mockTrackOrderViewModel = MockTrackOrderViewModel();
    when(
      mockTrackOrderViewModel.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(
      mockTrackOrderViewModel.uiEventsStream,
    ).thenAnswer((_) => const Stream.empty());
    when(mockTrackOrderViewModel.state).thenReturn(
      TrackOrderStates(orderState: BaseState.loaded(_activeOrder())),
    );
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
          child: OrderTrackingScreen(order: _activeOrder()),
        ),
      ),
    );
  }

  testWidgets('renders details view when showMap is false', (tester) async {
    await tester.pumpWidget(build());
    await tester.pump();

    expect(find.byType(DetailView), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('renders tracking route correctly', (tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        child: MaterialApp(
          theme: LightTheme().themeData,
          home: const Scaffold(body: Text('root')),
          routes: {
            '/track': (_) => BlocProvider<TrackOrderViewModel>.value(
              value: mockTrackOrderViewModel,
              child: OrderTrackingScreen(order: _activeOrder()),
            ),
          },
        ),
      ),
    );

    final context = tester.element(find.text('root'));
    Navigator.of(context).pushNamed('/track');
    await tester.pumpAndSettle();
    expect(find.byType(OrderTrackingScreen), findsOneWidget);
  });
}

ActiveOrderEntity _activeOrder() {
  return const ActiveOrderEntity(
    orderId: 'order_1',
    documentExists: true,
    userName: 'Mona',
    userImage: 'assets/image/user.png',
    userAddress: 'Nasr City',
    status: 'accepted',
  );
}
