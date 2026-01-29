import 'dart:async';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/services/maps/location_manager.dart';
import 'package:flower_app/features/address/presentation/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});


  @override
  State<GoogleMapView> createState() => GoogleMapViewState();
}

class GoogleMapViewState extends State<GoogleMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late final LocationManager _locationManager = LocationManager();
  Set<Marker> markers = {};
  @override
  void initState() {
    _locationManager.getUserLocation();
    super.initState();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: markers,
              onTap: (LatLng position) {
                setState(() {
                  markers.clear();
                  markers.add(
                    Marker(
                      markerId: const MarkerId('selected'),
                      position: position,
                    ),
                  );
                });
              },
            ),

            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          FloatingActionButton(
            heroTag: "pickLocation",
            backgroundColor: context.appTheme.primary,
            onPressed: () {
              LatLng location = markers.first.position;
              if (markers.isNotEmpty) {
                context.read<AddressViewModel>().loadLocation(location);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: context.appTheme.primary[60],
                    content: const Text('Please select a location first'),
                  ),
                );
              }
            },
            child: markers.isEmpty
                ? Icon(
                    Icons.location_on_outlined,
                    color: context.appTheme.backgroundColor,
                  )
                : Icon(Icons.done, color: context.appTheme.backgroundColor),
          ),
          FloatingActionButton(
            heroTag: "myCurrentLocation",
            backgroundColor: context.appTheme.primary,
            onPressed: _goToMyCurrentLocation,
            child: Icon(
              Icons.location_searching_outlined,
              color: context.appTheme.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    var currentLocation = await _locationManager.getUserLocation();
    final CameraPosition kCurrentLocation = CameraPosition(
      target: LatLng(
        currentLocation?.latitude ?? 0,
        currentLocation?.longitude ?? 0,
      ),
      zoom: 19.151926040649414,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(kCurrentLocation),
    );
  }
}
