import 'dart:convert';

import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/data/data_source/profile_local_data_source.dart';
import 'package:flower_app/features/profile/data/models/about_us_dto.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final String filePath = 'assets/json/about_us.json';
  @override
  Future<Result<AboutUsDto>> getAboutUs() async {
    try {
      final String jsonString = await rootBundle.loadString(filePath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final AboutUsDto aboutUsDto = AboutUsDto.fromJson(jsonMap);
      return Success<AboutUsDto>(aboutUsDto);
    } catch (e) {
      return Failure<AboutUsDto>(e.toString());
    }
  }
}
