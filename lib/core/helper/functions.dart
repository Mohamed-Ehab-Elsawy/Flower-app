import 'package:easy_localization/easy_localization.dart';

String? formatArrivalDate(DateTime? date) {
  if (date == null) return null;
  return DateFormat('dd MMM yyyy, HH:mm').format(date);
}
