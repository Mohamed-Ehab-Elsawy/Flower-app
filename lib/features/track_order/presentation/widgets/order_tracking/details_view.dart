import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/helper/assets_manager.dart';
import 'package:flower_app/core/helper/functions.dart';
import 'package:flower_app/core/widgets/custom_image_view.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/domain/entity/order_status.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flower_app/features/track_order/presentation/widgets/track_order_widgets/delivery_info_card.dart';
import 'package:flower_app/features/track_order/presentation/widgets/order_tracking/order_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailView extends StatelessWidget {
  final ActiveOrderEntity order;

  const DetailView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TrackOrderViewModel>();
    final isDelivered = order.orderStatus == OrderStatus.delivered;
    final arrivalDisplay = formatArrivalDate(order.startedAt);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      order: order,
                      onCallTap: () => viewModel.doIntent(
                        CallDeliveryIntent(order.driverPhoneNumber),
                      ),
                      onMessageTap: () => viewModel.doIntent(
                        MessageDeliveryIntent(order.driverPhoneNumber),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: CustomImageView(imagePath: AssetsManager.icCarSvg),
                    ),
                    const SizedBox(height: 40),
                    OrderStepper(
                      steps: defaultOrderSteps(),
                      currentStatus: order.orderStatus,
                    ),
                  ],
                ),
              ),
            ),
            if (isDelivered)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => viewModel.doIntent(ShowMapIntent()),
                      child: Text('show_map'.tr()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          viewModel.doIntent(OrderDeliveredIntent(order)),
                      child: Text('order_delivered'.tr()),
                    ),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: () => viewModel.doIntent(ShowMapIntent()),
                child: Text('show_map'.tr()),
              ),
          ],
        ),
      ),
    );
  }
}
