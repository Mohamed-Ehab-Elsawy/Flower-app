import 'package:equatable/equatable.dart';

class AddressRequestEntity extends Equatable {
  final String street;
  final String phone;
  final String city;
  final String? lat;
  final String? long;
  final String username;

  const AddressRequestEntity({
    required this.street,
    required this.phone,
    required this.city,
    this.lat,
    this.long,
    required this.username,
  });

  AddressRequestEntity copyWith({
    String? street,
    String? phone,
    String? city,
    String? username,
    String? lat,
    String? long,
  }) {
    return AddressRequestEntity(
      street: street ?? this.street,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [street, phone, city, lat, long, username];
}
