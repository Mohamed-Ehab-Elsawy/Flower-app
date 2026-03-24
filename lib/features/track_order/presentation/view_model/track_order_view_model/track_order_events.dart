import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';

sealed class Intent {}

class ListenToOrderIntent extends Intent {
  final String orderId;

  ListenToOrderIntent(this.orderId);
}

class DisposeOrderListenerIntent extends Intent {}

class ShowMapIntent extends Intent {}

class ShowOrderDetailsIntent extends Intent {}

class OrderDeliveredIntent extends Intent {
  final ActiveOrderEntity order;
  OrderDeliveredIntent(this.order);
}

class CallDeliveryIntent extends Intent {
  final String? phone;
  CallDeliveryIntent(this.phone);
}

class MessageDeliveryIntent extends Intent {
  final String? phone;
  final String? message;
  MessageDeliveryIntent(this.phone, {this.message});
}

// ─── UI Events (Stream) ───────────────────────────────
sealed class TrackOrderUIEvents {}

class NavigatePopScreen extends TrackOrderUIEvents {}

class LaunchExternalUrl extends TrackOrderUIEvents {
  final Uri uri;
  LaunchExternalUrl(this.uri);
}
