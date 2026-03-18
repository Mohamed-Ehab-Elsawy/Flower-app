import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/widgets/order_tracking/details_view.dart';
import 'package:flower_app/features/track_order/presentation/widgets/order_tracking/map_view.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTrackingScreen extends StatefulWidget {
  final ActiveOrderEntity order;
  final String? userDestLat;
  final String? userDestLng;

  const OrderTrackingScreen({
    super.key,
    required this.order,
    this.userDestLat,
    this.userDestLng,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  StreamSubscription<TrackOrderUIEvents>? _uiEventsSubscription;
  late final TrackOrderViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<TrackOrderViewModel>();
    _listenToUIEvents();
  }

  void _listenToUIEvents() {
    _uiEventsSubscription = _viewModel.uiEventsStream.listen((event) {
      if (!mounted) return;
      switch (event) {
        case NavigatePopScreen():
          Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _uiEventsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackOrderViewModel, TrackOrderStates>(
      builder: (context, state) {
        final order = state.orderState.data ?? widget.order;
        return Scaffold(
          appBar: AppBar(title: Text('track_order'.tr())),
          body: state.showMap
              ? SafeArea(
                  child: MapsView(
                    userDestLat: widget.userDestLat,
                    userDestLng: widget.userDestLng,
                  ),
                )
              : DetailView(order: order),
        );
      },
    );
  }
}
