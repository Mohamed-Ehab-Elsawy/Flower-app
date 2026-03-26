import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/widgets/maps/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class MapBody extends StatelessWidget {
  final ActiveOrderEntity order;
  final LatLng? userPosition;
  final BitmapDescriptor? driverIcon;
  final BitmapDescriptor? destIcon;
  final LatLng initialCenter;
  final void Function(GoogleMapController) onMapCreated;

  const MapBody({
    super.key,
    required this.order,
    required this.userPosition,
    required this.driverIcon,
    this.destIcon,
    required this.initialCenter,
    required this.onMapCreated,
  });

  // Pill width ≈ 3+18+4+~45+8 ≈ 78px  |  tail tip x = 3+9 = 12px  →  12/78 ≈ 0.154
  static const _kAnchor = Offset(0.154, 1.0);

  Set<Marker> _markers() {
    final fallback = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRose,
    );
    return {
      if (order.hasDriverPosition)
        Marker(
          markerId: const MarkerId('driver'),
          position: LatLng(order.latDouble!, order.longDouble!),
          icon: driverIcon ?? fallback,
          anchor: _kAnchor,
        ),
      if (userPosition != null)
        Marker(
          markerId: const MarkerId('user'),
          position: userPosition!,
          icon: destIcon ?? fallback,
          anchor: _kAnchor,
        ),
    };
  }

  Set<Polyline> _polylines(BuildContext context) {
    final pts = <LatLng>[
      if (order.hasDriverPosition) LatLng(order.latDouble!, order.longDouble!),
      if (userPosition != null) userPosition!,
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
            zoom: 14.5,
          ),
          style: _kMapStyle,
          onMapCreated: onMapCreated,
          markers: _markers(),
          polylines: _polylines(context),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: BottomSheetWidget(order: order),
        ),
      ],
    );
  }
}
