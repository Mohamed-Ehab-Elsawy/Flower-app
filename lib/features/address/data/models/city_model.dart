import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String? id;
  final String? governorateId;
  final String? cityNameAr;
  final String? cityNameEn;

  const CityModel({
    required this.id,
    required this.governorateId,
    required this.cityNameAr,
    required this.cityNameEn,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      governorateId: json['governorate_id'],
      cityNameAr: json['city_name_ar'],
      cityNameEn: json['city_name_en'],
    );
  }

  @override
  List<Object?> get props => [id, governorateId, cityNameAr, cityNameEn];
}
