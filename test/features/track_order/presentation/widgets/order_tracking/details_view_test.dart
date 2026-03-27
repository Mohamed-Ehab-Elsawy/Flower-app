import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flower_app/features/track_order/presentation/widgets/order_tracking/details_view.dart';
import 'package:flutter/material.dart' hide Intent;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'details_view_test.mocks.dart';

@GenerateMocks([TrackOrderViewModel])
void main() {
  late MockTrackOrderViewModel mockTrackOrderViewModel;

  setUp(() {
    mockTrackOrderViewModel = MockTrackOrderViewModel();
    when(
      mockTrackOrderViewModel.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(mockTrackOrderViewModel.state).thenReturn(
      const TrackOrderStates(
        orderState: BaseState<ActiveOrderEntity>(
          requestState: RequestState.init,
        ),
      ),
    );
    when(
      mockTrackOrderViewModel.doIntent(argThat(isA<Intent>())),
    ).thenReturn(null);
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
          child: const Scaffold(
            body: DetailView(
              order: ActiveOrderEntity(
                orderId: 'order_1',
                documentExists: true,
                driverName: 'Driver',
                driverImage: 'assets/image/user.png',
                driverPhoneNumber: '+201554443332',
                userName: 'Mona',
                userImage: 'assets/image/placeholder.png',
                userAddress: 'Nasr City',
                status: 'accepted',
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('phone and chat icons dispatch driver intents', (tester) async {
    await tester.pumpWidget(build());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.phone_outlined));
    await tester.pump();
    verify(
      mockTrackOrderViewModel.doIntent(
        argThat(
          predicate<CallDeliveryIntent>(
            (intent) => intent.phone == '+201554443332',
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
            (intent) => intent.phone == '+201554443332',
          ),
        ),
      ),
    ).called(1);
  });
}
