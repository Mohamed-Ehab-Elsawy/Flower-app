import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CityEntity {
  final String nameAr;
  final String nameEn;
  final String governorateId;

  CityEntity({
    required this.nameAr,
    required this.nameEn,
    required this.governorateId,
  });

  String getName(BuildContext context) {
    return context.locale.languageCode == 'ar' ? nameAr : nameEn;
  }
}
