import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/helper/functions.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flower_app/features/track_order/presentation/widgets/track_order_widgets/delivery_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomCard extends StatelessWidget {
  final ActiveOrderEntity order;
  const BottomCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TrackOrderViewModel>();
    final arrivalDisplay = formatArrivalDate(order.startedAt);
    final deliveryName = resolveDeliveryName(order) ?? 'Driver';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (arrivalDisplay != null) ...[
            Text(
              'estimated_arrival'.tr(),
              style: context.appTheme.regular14.copyWith(
                color: context.appTheme.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(arrivalDisplay, style: context.appTheme.medium16),
            const SizedBox(height: 16),
          ],
          DeliveryInfoCard(
            deliveryName: deliveryName,
            deliveryPhone: order.phone,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => viewModel.doIntent(ShowOrderDetailsIntent()),
            child: Text('order_details'.tr()),
          ),
        ],
      ),
    );
  }
}
