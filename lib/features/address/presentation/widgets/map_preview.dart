import 'package:flower_app/features/address/presentation/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/features/address/presentation/view_model/address_state.dart';

class MapPreview extends StatelessWidget {
  const MapPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressViewModel, AddressState>(
      builder: (context, state) {
        final location = state.location?.data;
        final CameraPosition initialPosition = CameraPosition(
          target:
              location ?? const LatLng(30.0444, 31.2357), // Default to Cairo
          zoom: 14.4746,
        );

        return GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(AppRoutes.googleMapService),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AbsorbPointer(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: initialPosition,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  liteModeEnabled: true,
                  markers: location != null
                      ? {
                          Marker(
                            markerId: const MarkerId('selected'),
                            position: location,
                          ),
                        }
                      : {},
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  }
