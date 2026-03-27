import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

String? formatArrivalDate(DateTime? date) {
  if (date == null) return null;
  return DateFormat('dd MMM yyyy, HH:mm').format(date);
}

Future<void> launchExternal(Uri uri) async {
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
