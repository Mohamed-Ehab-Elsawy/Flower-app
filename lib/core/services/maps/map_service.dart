
import 'package:flutter/material.dart';

class LatLngEntity{
  double lat;
  double lng;

  LatLngEntity({required this.lat, required this.lng});
}

abstract class MapService{
  Widget build({
    required LatLngEntity initialLocation,
    required Function(LatLngEntity) onTap,
  });
}