import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';

class TrackOrderStates extends Equatable {
  final BaseState<ActiveOrderEntity> orderState;
  final bool showMap;

  /// User destination from address (lat/long) when opening track order; used for map when order has no destLat/destLng.
  final String? userDestLat;
  final String? userDestLng;

  const TrackOrderStates({
    required this.orderState,
    this.showMap = false,
    this.userDestLat,
    this.userDestLng,
  });

  factory TrackOrderStates.initial() =>
      TrackOrderStates(orderState: BaseState.init());

  TrackOrderStates copyWith({
    BaseState<ActiveOrderEntity>? orderState,
    BaseState<void>? sendOrderDeliveredState,
    bool? showMap,
    String? userDestLat,
    String? userDestLng,
  }) {
    return TrackOrderStates(
      orderState: orderState ?? this.orderState,
      showMap: showMap ?? this.showMap,
      userDestLat: userDestLat ?? this.userDestLat,
      userDestLng: userDestLng ?? this.userDestLng,
    );
  }

  double? get userDestLatDouble {
    if (userDestLat == null || userDestLat!.isEmpty) return null;
    return double.tryParse(userDestLat!);
  }

  double? get userDestLngDouble {
    if (userDestLng == null || userDestLng!.isEmpty) return null;
    return double.tryParse(userDestLng!);
  }

  bool get hasUserDest =>
      userDestLatDouble != null && userDestLngDouble != null;

  @override
  List<Object?> get props => [orderState, showMap, userDestLat, userDestLng];
}
