import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/track_order/presentation/widgets/order_tracking/pill_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/helper/functions.dart';
import 'package:flower_app/features/track_order/data/models/track_order_args.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flower_app/features/track_order/presentation/widgets/track_order_widgets/delivery_info_card.dart';

// ════════════════════════════════════════════════════════════════════════════
// CUSTOMIZATION — change anything here without touching the logic below
// ════════════════════════════════════════════════════════════════════════════

/// Fallback map centre (Cairo downtown) when no positions are available.
const _kFallback = LatLng(30.02599441795995, 31.1991091073733);

/// Marker pill labels — change these to localize.
const _kLabelDelivery = 'Delivery';
const _kLabelStore = 'Flowery';
const _kLabelApartment = 'Apartment';

// ─── Map style ────────────────────────────────────────────────────────────────
// Keeps all road labels and street names visible.
// Only tones down noisy POI clutter and saturates roads slightly for contrast.
const _kMapStyle = '''
[
  {
    "featureType": "all",
    "elementType": "geometry",
    "stylers": [{ "saturation": -15 }]
  },
  {
    "featureType": "poi",
    "elementType": "labels.icon",
    "stylers": [{ "visibility": "off" }]
  },
  {
    "featureType": "poi.business",
    "stylers": [{ "visibility": "off" }]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [{ "color": "#d8ead3" }]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [{ "color": "#ffffff" }]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [{ "color": "#e0e0e0" }, { "weight": 1 }]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry.fill",
    "stylers": [{ "color": "#f7f7f7" }]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.fill",
    "stylers": [{ "color": "#f0f0f0" }]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [{ "color": "#666666" }]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.stroke",
    "stylers": [{ "color": "#ffffff" }, { "weight": 3 }]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [{ "color": "#b8d8e8" }]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.fill",
    "stylers": [{ "color": "#f2f2ef" }]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry.fill",
    "stylers": [{ "color": "#eaf0e8" }]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [{ "color": "#c8c8c8" }]
  },
  {
    "featureType": "transit",
    "elementType": "labels.icon",
    "stylers": [{ "visibility": "off" }]
  }
]
''';

class MapsView extends StatefulWidget {
  final String? userDestLat;
  final String? userDestLng;

  const MapsView({super.key, this.userDestLat, this.userDestLng});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  GoogleMapController? _mapController;
  LatLng? _lastAnimatedDriverPos;

  // ── Marker bitmaps ───────────────────────────────────────────────────────
  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _storeIcon;
  BitmapDescriptor? _destIcon;

  // Capture infrastructure
  final _driverKey = GlobalKey();
  final _storeKey = GlobalKey();
  final _destKey = GlobalKey();
  OverlayEntry? _markersOverlay;

  // ── Timer ────────────────────────────────────────────────────────────────
  Timer? _refreshTimer;

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    // Render pill-marker widgets off-screen after the first frame so that
    // all fonts/icons are guaranteed to be loaded before we capture them.
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

  // ── Marker capture ────────────────────────────────────────────────────────

  /// Step 1 — insert invisible widgets into the Overlay so Flutter lays them out.
  void _insertMarkersOverlay() {
    if (!mounted) return;
    _markersOverlay = OverlayEntry(
      builder: (_) => _OffscreenMarkers(
        driverKey: _driverKey,
        storeKey: _storeKey,
        destKey: _destKey,
      ),
    );
    Overlay.of(context).insert(_markersOverlay!);
    // Step 2 — wait one more frame for paint to complete, then capture.
    WidgetsBinding.instance.addPostFrameCallback((_) => _captureAllMarkers());
  }

  /// Step 2 — capture each RepaintBoundary as a BitmapDescriptor.
  Future<void> _captureAllMarkers() async {
    final results = await Future.wait([
      _captureKey(_driverKey),
      _captureKey(_storeKey),
      _captureKey(_destKey),
    ]);
    _markersOverlay?.remove();
    _markersOverlay = null;
    if (!mounted) return;
    setState(() {
      _driverIcon = results[0];
      _storeIcon = results[1];
      _destIcon = results[2];
    });
  }

  Future<BitmapDescriptor?> _captureKey(GlobalKey key) async {
    try {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
    } catch (_) {
      return null;
    }
  }

  // ── Camera ────────────────────────────────────────────────────────────────

  void _onMapCreated(GoogleMapController c) {
    _mapController = c;
    c.setMapStyle(_kMapStyle);
    _fitBounds();
  }

  /// Animates the camera so that all three markers are fully visible
  /// with a comfortable padding that accounts for the bottom sheet.
  void _fitBounds() {
    if (_mapController == null) return;
    final vm = context.read<TrackOrderViewModel>();
    final order = vm.state.orderState.data;
    if (order == null) return;
    final dest = _effectiveDest(context, order, vm.state);

    final pts = <LatLng>[
      if (order.hasStorePosition)
        LatLng(order.storeLatDouble!, order.storeLngDouble!),
      if (order.hasDriverPosition) LatLng(order.latDouble!, order.longDouble!),
      if (dest != null) dest,
    ];
    if (pts.isEmpty) return;

    if (pts.length == 1) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: pts.single, zoom: 14),
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
        120,
      ),
    );
  }

  // ── Destination resolution (priority chain) ───────────────────────────────

  LatLng? _effectiveDest(
    BuildContext ctx,
    ActiveOrderEntity order,
    TrackOrderStates state,
  ) {
    // 1. Dest embedded in the order stream
    if (order.hasDestPosition) {
      return LatLng(order.destLatDouble!, order.destLngDouble!);
    }
    // 2. Dest stored in the VM state (from a previous intent)
    if (state.hasUserDest) {
      return LatLng(state.userDestLatDouble!, state.userDestLngDouble!);
    }
    // 3. Passed directly as widget props
    final lat = _parseCoord(widget.userDestLat);
    final lng = _parseCoord(widget.userDestLng);
    if (lat != null && lng != null) return LatLng(lat, lng);
    // 4. Passed via route arguments
    final args = ModalRoute.of(ctx)?.settings.arguments;
    if (args is TrackOrderArgs) {
      final rLat = _parseCoord(args.userDestLat);
      final rLng = _parseCoord(args.userDestLng);
      if (rLat != null && rLng != null) return LatLng(rLat, rLng);
    }
    // 5. Fallback: synthesise a point near the driver so the polyline renders
    if (order.hasDriverPosition) {
      return LatLng(order.latDouble! + 0.008, order.longDouble! + 0.005);
    }
    return null;
  }

  static double? _parseCoord(String? v) => (v == null || v.trim().isEmpty)
      ? null
      : num.tryParse(v.trim())?.toDouble();

  LatLng _initialCenter(ActiveOrderEntity order, LatLng? dest) {
    if (order.hasDriverPosition) {
      return LatLng(order.latDouble!, order.longDouble!);
    }
    if (order.hasStorePosition) {
      return LatLng(order.storeLatDouble!, order.storeLngDouble!);
    }
    return dest ?? _kFallback;
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackOrderViewModel, TrackOrderStates>(
      listenWhen: (prev, curr) =>
          prev.orderState.data?.lat != curr.orderState.data?.lat ||
          prev.orderState.data?.long != curr.orderState.data?.long,
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
      buildWhen: (prev, curr) =>
          prev.orderState != curr.orderState ||
          prev.userDestLat != curr.userDestLat ||
          prev.userDestLng != curr.userDestLng,
      builder: (ctx, state) {
        final order = state.orderState.data;
        if (order == null) {
          return Center(
            child: CircularProgressIndicator(color: ctx.appTheme.primary),
          );
        }
        final dest = _effectiveDest(ctx, order, state);
        return _MapBody(
          order: order,
          effectiveDest: dest,
          driverIcon: _driverIcon,
          storeIcon: _storeIcon,
          destIcon: _destIcon,
          initialCenter: _initialCenter(order, dest),
          onMapCreated: _onMapCreated,
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Off-screen marker widgets (invisible, inserted via Overlay for capture)
// ════════════════════════════════════════════════════════════════════════════

class _OffscreenMarkers extends StatelessWidget {
  final GlobalKey driverKey, storeKey, destKey;

  const _OffscreenMarkers({
    required this.driverKey,
    required this.storeKey,
    required this.destKey,
  });

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
          const PillMarker(icon: Icons.delivery_dining, label: _kLabelDelivery),
        ),
        place(
          storeKey,
          const PillMarker(icon: Icons.local_florist, label: _kLabelStore),
        ),
        place(
          destKey,
          const PillMarker(icon: Icons.home_rounded, label: _kLabelApartment),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Map body
// ════════════════════════════════════════════════════════════════════════════

class _MapBody extends StatelessWidget {
  final ActiveOrderEntity order;
  final LatLng? effectiveDest;
  final BitmapDescriptor? driverIcon;
  final BitmapDescriptor? storeIcon;
  final BitmapDescriptor? destIcon;
  final LatLng initialCenter;
  final void Function(GoogleMapController) onMapCreated;

  const _MapBody({
    required this.order,
    required this.effectiveDest,
    required this.driverIcon,
    this.storeIcon,
    this.destIcon,
    required this.initialCenter,
    required this.onMapCreated,
  });

  // ── Anchor calculation ─────────────────────────────────────────────────
  // Pill logical width  ≈  5 + 32 + 8 + ~70(label) + 14  ≈  129 px
  // Tail logical x tip = 5 (leftPad) + 16 (half circle) = 21 px
  // Plus the tail itself is 16px wide, centred at 13+8 = 21 → same.
  // normalised anchor x = 21 / 129 ≈ 0.163 ; y = 1.0
  static const _kAnchor = Offset(0.163, 1.0);

  Set<Marker> _markers() {
    final fallback = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRose,
    );
    return {
      if (order.hasStorePosition)
        Marker(
          markerId: const MarkerId('store'),
          position: LatLng(order.storeLatDouble!, order.storeLngDouble!),
          icon: storeIcon ?? fallback,
          anchor: _kAnchor,
        ),
      if (order.hasDriverPosition)
        Marker(
          markerId: const MarkerId('driver'),
          position: LatLng(order.latDouble!, order.longDouble!),
          icon: driverIcon ?? fallback,
          anchor: _kAnchor,
        ),
      if (effectiveDest != null)
        Marker(
          markerId: const MarkerId('destination'),
          position: effectiveDest!,
          icon: destIcon ?? fallback,
          anchor: _kAnchor,
        ),
    };
  }

  Set<Polyline> _polylines(BuildContext context) {
    final pts = <LatLng>[
      if (order.hasStorePosition)
        LatLng(order.storeLatDouble!, order.storeLngDouble!),
      if (order.hasDriverPosition) LatLng(order.latDouble!, order.longDouble!),
      if (effectiveDest != null) effectiveDest!,
    ];
    if (pts.length < 2) return {};
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: pts,
        color: context.appTheme.primary,
        width: 5,
        geodesic: true,
        jointType: JointType.round,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: false,
          buildingsEnabled: true,
          indoorViewEnabled: false,
          initialCameraPosition: CameraPosition(
            target: initialCenter,
            zoom: 14,
          ),
          onMapCreated: onMapCreated,
          markers: _markers(),
          polylines: _polylines(context),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _BottomSheet(order: order),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Bottom sheet
// ════════════════════════════════════════════════════════════════════════════

class _BottomSheet extends StatelessWidget {
  final ActiveOrderEntity order;
  const _BottomSheet({required this.order});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TrackOrderViewModel>();
    final arrival = formatArrivalDate(order.startedAt);
    final driverName = resolveDeliveryName(order) ?? 'Driver';

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
            const SizedBox(height: 4),
            Text(arrival, style: context.appTheme.medium16),
            const SizedBox(height: 16),
          ],
          DeliveryInfoCard(
            deliveryName: driverName,
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
