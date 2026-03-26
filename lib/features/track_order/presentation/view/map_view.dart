import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flower_app/features/track_order/presentation/widgets/maps/map_body.dart';
import 'package:flower_app/features/track_order/presentation/widgets/maps/pill_marker_custom_painter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Fallback map centre (Cairo downtown) when no positions are available.
const _kFallback = LatLng(30.02599441795995, 31.1991091073733);

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  GoogleMapController? _mapController;
  LatLng? _lastAnimatedDriverPos;

  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _destIcon;

  // Capture infrastructure
  final _driverKey = GlobalKey();
  final _destKey = GlobalKey();
  OverlayEntry? _markersOverlay;

  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _insertMarkersOverlay(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Start the periodic refresh that re-draws markers with the latest driver position.
    _refreshTimer ??= Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _mapController?.dispose();
    _markersOverlay?.remove();
    super.dispose();
  }

  void _insertMarkersOverlay() {
    if (!mounted) return;
    _markersOverlay = OverlayEntry(
      builder: (_) =>
          _OffscreenMarkers(driverKey: _driverKey, destKey: _destKey),
    );
    Overlay.of(context).insert(_markersOverlay!);

    WidgetsBinding.instance.addPostFrameCallback((_) => _captureAllMarkers());
  }

  Future<void> _captureAllMarkers() async {
    final results = await Future.wait([
      _captureKey(_driverKey),
      _captureKey(_destKey),
    ]);
    _markersOverlay?.remove();
    _markersOverlay = null;
    if (!mounted) return;
    setState(() {
      _driverIcon = results[0];
      _destIcon = results[1];
    });
  }

  Future<BitmapDescriptor?> _captureKey(GlobalKey key) async {
    try {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2.0);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
    } catch (_) {
      return null;
    }
  }

  void _onMapCreated(GoogleMapController c) {
    _mapController = c;
    final order = context.read<TrackOrderViewModel>().state.orderState.data;
    if (order != null && order.hasUserPosition) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(order.userLatDouble!, order.userLngDouble!),
            zoom: 15.5,
          ),
        ),
      );
      return;
    }
    _fitBounds();
  }

  void _fitBounds() {
    if (_mapController == null) return;
    final vm = context.read<TrackOrderViewModel>();
    final order = vm.state.orderState.data;
    if (order == null) return;
    final user = _userPosition(order);

    final pts = <LatLng>[
      if (order.hasDriverPosition) LatLng(order.latDouble!, order.longDouble!),
      if (user != null) user,
    ];
    if (pts.isEmpty) return;

    if (pts.length == 1) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: pts.single, zoom: 15.5),
        ),
      );
      return;
    }

    double minLat = pts.first.latitude, maxLat = minLat;
    double minLng = pts.first.longitude, maxLng = minLng;
    for (final p in pts) {
      minLat = min(minLat, p.latitude);
      maxLat = max(maxLat, p.latitude);
      minLng = min(minLng, p.longitude);
      maxLng = max(maxLng, p.longitude);
    }
    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        120.0,
      ),
    );
  }

  LatLng? _userPosition(ActiveOrderEntity order) {
    if (!order.hasUserPosition) return null;
    return LatLng(order.userLatDouble!, order.userLngDouble!);
  }

  LatLng _initialCenter(ActiveOrderEntity order, LatLng? userPosition) {
    if (order.hasUserPosition) {
      return LatLng(order.userLatDouble!, order.userLngDouble!);
    }
    if (order.hasDriverPosition) {
      return LatLng(order.latDouble!, order.longDouble!);
    }
    return userPosition ?? _kFallback;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackOrderViewModel, TrackOrderStates>(
      listenWhen: (previous, current) =>
          previous.orderState.data?.lat != current.orderState.data?.lat ||
          previous.orderState.data?.long != current.orderState.data?.long,
      listener: (ctx, state) {
        final order = state.orderState.data;
        if (order == null ||
            !order.hasDriverPosition ||
            _mapController == null) {
          return;
        }
        final pos = LatLng(order.latDouble!, order.longDouble!);
        if (pos == _lastAnimatedDriverPos) return;
        _lastAnimatedDriverPos = pos;
        _mapController!.animateCamera(CameraUpdate.newLatLng(pos));
      },
      buildWhen: (previous, current) =>
          previous.orderState != current.orderState,
      builder: (context, state) {
        final order = state.orderState.data;
        if (order == null) {
          return Center(
            child: CircularProgressIndicator(color: context.appTheme.primary),
          );
        }
        final userPosition = _userPosition(order);
        return MapBody(
          order: order,
          userPosition: userPosition,
          driverIcon: _driverIcon,
          destIcon: _destIcon,
          initialCenter: _initialCenter(order, userPosition),
          onMapCreated: _onMapCreated,
        );
      },
    );
  }
}

class _OffscreenMarkers extends StatelessWidget {
  final GlobalKey driverKey, destKey;

  const _OffscreenMarkers({required this.driverKey, required this.destKey});

  @override
  Widget build(BuildContext context) {
    Widget place(GlobalKey k, Widget child) => Positioned(
      left: -9999,
      top: -9999,
      child: RepaintBoundary(key: k, child: child),
    );
    return Stack(
      children: [
        place(
          driverKey,
          PillMarkerCustomPainterWidget(
            icon: Icons.delivery_dining,
            label: 'delivery'.tr(),
          ),
        ),
        place(
          destKey,
          PillMarkerCustomPainterWidget(
            icon: Icons.home_rounded,
            label: 'apartment'.tr(),
          ),
        ),
      ],
    );
  }
}
