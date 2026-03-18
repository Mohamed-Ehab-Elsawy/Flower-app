/// Arguments for opening the track order screen.
/// [userDestLat] and [userDestLng] come from the selected delivery address
/// (e.g. from checkout or saved order) so the map can show destination and polyline
/// even when the backend does not yet provide destLat/destLng.
class TrackOrderArgs {
  final String orderId;
  final String? userDestLat;
  final String? userDestLng;

  const TrackOrderArgs({
    required this.orderId,
    this.userDestLat,
    this.userDestLng,
  });
}
