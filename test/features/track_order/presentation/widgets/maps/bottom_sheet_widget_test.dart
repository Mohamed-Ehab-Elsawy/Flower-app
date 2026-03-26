import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flower_app/features/track_order/presentation/widgets/maps/bottom_sheet_widget.dart';
import 'package:flutter/material.dart' hide Intent;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bottom_sheet_widget_test.mocks.dart';

@GenerateMocks([TrackOrderViewModel])
void main() {
  late MockTrackOrderViewModel mockTrackOrderViewModel;

  setUp(() {
    mockTrackOrderViewModel = MockTrackOrderViewModel();
    when(
      mockTrackOrderViewModel.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(mockTrackOrderViewModel.state).thenReturn(TrackOrderStates.initial());
    when(
      mockTrackOrderViewModel.doIntent(argThat(isA<Intent>())),
    ).thenReturn(null);
  });

  Widget build({DateTime? startedAt}) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        theme: LightTheme().themeData,
        home: BlocProvider<TrackOrderViewModel>.value(
          value: mockTrackOrderViewModel,
          child: Scaffold(
            body: BottomSheetWidget(
              order: ActiveOrderEntity(
                orderId: 'order_1',
                documentExists: true,
                driverName: 'Driver',
                driverImage: 'assets/image/user.png',
                driverPhoneNumber: '+201001112233',
                userName: 'Mona',
                userImage: 'assets/image/placeholder.png',
                userAddress: 'Nasr City',
                startedAt: startedAt,
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('shows estimated arrival when startedAt exists', (tester) async {
    await tester.pumpWidget(build(startedAt: DateTime(2026, 3, 26, 10, 30)));
    await tester.pump();

    expect(find.byType(BottomSheetWidget), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('clicking order details dispatches ShowOrderDetailsIntent', (
    tester,
  ) async {
    await tester.pumpWidget(build(startedAt: null));
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(
      mockTrackOrderViewModel.doIntent(argThat(isA<ShowOrderDetailsIntent>())),
    ).called(1);
  });

  testWidgets('phone and chat icons dispatch call/message intents', (
    tester,
  ) async {
    await tester.pumpWidget(build(startedAt: null));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.phone_outlined));
    await tester.pump();
    verify(
      mockTrackOrderViewModel.doIntent(
        argThat(
          predicate<CallDeliveryIntent>(
            (intent) => intent.phone == '+201001112233',
          ),
        ),
      ),
    ).called(1);

    await tester.tap(find.byIcon(Icons.chat_outlined));
    await tester.pump();
    verify(
      mockTrackOrderViewModel.doIntent(
        argThat(
          predicate<MessageDeliveryIntent>(
            (intent) => intent.phone == '+201001112233',
          ),
        ),
      ),
    ).called(1);
  });
}
