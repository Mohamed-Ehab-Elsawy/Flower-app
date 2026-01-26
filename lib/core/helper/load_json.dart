import 'dart:convert';

import 'package:flower_app/features/address/data/models/city_model.dart';
import 'package:flutter/services.dart';

class LoadAsset {
  static Future<List<CityModel>> loadCitiesList(String path) async {
    String response = await rootBundle.loadString(path);
    final data = await json.decode(response);
    final List<dynamic> list = data['data'];
    final List<CityModel> cities = list
        .map((e) => CityModel.fromJson(e))
        .toList();
    return cities;
  }
}
