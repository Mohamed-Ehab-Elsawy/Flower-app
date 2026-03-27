import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/helper/functions.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flower_app/features/track_order/presentation/widgets/track_order_widgets/delivery_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetWidget extends StatelessWidget {
  final ActiveOrderEntity order;
  const BottomSheetWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TrackOrderViewModel>();
    final arrival = formatArrivalDate(order.startedAt);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          if (arrival != null) ...[
            Text(
              'estimated_arrival'.tr(),
              style: context.appTheme.regular14.copyWith(
                color: context.appTheme.grey,
              ),
            ),
            context.h(4),
            Text(arrival, style: context.appTheme.medium16),
            context.h(16),
          ],
          DeliveryInfoCard(
            order: order,
            onCallTap: () =>
                viewModel.doIntent(CallDeliveryIntent(order.driverPhoneNumber)),
            onMessageTap: () => viewModel.doIntent(
              MessageDeliveryIntent(order.driverPhoneNumber),
            ),
          ),
          context.h(16),
          ElevatedButton(
            onPressed: () => viewModel.doIntent(ShowOrderDetailsIntent()),
            child: Text('order_details'.tr()),
          ),
        ],
      ),
    );
  }
}
