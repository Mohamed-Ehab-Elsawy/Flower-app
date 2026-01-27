import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';

sealed class AddressEvents {}

sealed class AddressUiEvent {}

class GetUserAddressesEvents extends AddressEvents {
  final List<AddressesEntity>? addresses;

  GetUserAddressesEvents({this.addresses});
}

class SelectAddressEvents extends AddressEvents {
  final int selectedAddresses;

  SelectAddressEvents({required this.selectedAddresses});
}
