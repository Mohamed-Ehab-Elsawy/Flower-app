import 'package:equatable/equatable.dart';

class CityDto extends Equatable {
  final String? id;
  final String? governorateId;
  final String? cityNameAr;
  final String? cityNameEn;

  const CityDto({
    required this.id,
    required this.governorateId,
    required this.cityNameAr,
    required this.cityNameEn,
  });

  factory CityDto.fromJson(Map<String, dynamic> json) {
    return CityDto(
      id: json['id'],
      governorateId: json['governorate_id'],
      cityNameAr: json['city_name_ar'],
      cityNameEn: json['city_name_en'],
    );
  }

  @override
  List<Object?> get props => [id, governorateId, cityNameAr, cityNameEn];
}
