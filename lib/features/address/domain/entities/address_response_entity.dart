import 'package:equatable/equatable.dart';

class AddressResponseEntity extends Equatable {
  final String? message;
  final List<AddressEntity>? address;

  const AddressResponseEntity({this.message, this.address});

  @override
  List<Object?> get props => [message, address];
}

class AddressEntity extends Equatable {
  final String? id;
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;

  const AddressEntity({
    this.id,
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  @override
  List<Object?> get props => [id, street, phone, city, lat, long, username];
}
