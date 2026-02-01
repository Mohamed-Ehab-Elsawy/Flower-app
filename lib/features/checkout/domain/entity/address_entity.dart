import 'package:equatable/equatable.dart';

class AddressesEntity extends Equatable {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;
  final String? id;

  const AddressesEntity({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  @override
  List<Object?> get props => [id];
}
