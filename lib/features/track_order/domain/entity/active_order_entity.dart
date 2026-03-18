import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/features/track_order/domain/entity/order_status.dart';

class ActiveOrderEntity extends Equatable {
  final String orderId;
  final String driverId;
  final String userId;

  final String driverToken;
  final String userToken;

  final String storeName;
  final String storeAddress;
  final String storeImage;
  final String? storeLat;
  final String? storeLng;

  final String? driverName;
  final String userName;
  final String userImage;
  final String userAddress;
  final String? destLat;
  final String? destLng;

  final double totalPrice;

  final String status;

  final DateTime? startedAt;
  final String? long;
  final String? lat;
  final String? city;
  final String? street;
  final String? phone;
  final bool documentExists;

  const ActiveOrderEntity({
    this.orderId = '',
    this.driverId = '',
    this.userId = '',
    this.driverToken = '',
    this.userToken = '',
    this.storeName = '',
    this.storeAddress = '',
    this.storeImage = '',
    this.storeLat,
    this.storeLng,
    this.driverName,
    this.userName = '',
    this.userImage = '',
    this.userAddress = '',
    this.destLat,
    this.destLng,
    this.totalPrice = 0,
    this.status = '',
    this.startedAt,
    this.long,
    this.lat,
    this.city,
    this.street,
    this.phone,
    required this.documentExists,
  });

  /// Parsed [OrderStatus] from [status] for stepper and routing.
  OrderStatus get orderStatus => OrderStatusX.fromString(status);

  /// Driver position for map; null if not available.
  double? get latDouble {
    if (lat == null || lat!.isEmpty) return null;
    return double.tryParse(lat!);
  }

  double? get longDouble {
    if (long == null || long!.isEmpty) return null;
    return double.tryParse(long!);
  }

  /// Whether driver position is available for map.
  bool get hasDriverPosition => latDouble != null && longDouble != null;

  double? get storeLatDouble => storeLat != null && storeLat!.isNotEmpty
      ? double.tryParse(storeLat!)
      : null;
  double? get storeLngDouble => storeLng != null && storeLng!.isNotEmpty
      ? double.tryParse(storeLng!)
      : null;
  double? get destLatDouble =>
      destLat != null && destLat!.isNotEmpty ? double.tryParse(destLat!) : null;
  double? get destLngDouble =>
      destLng != null && destLng!.isNotEmpty ? double.tryParse(destLng!) : null;
  bool get hasStorePosition => storeLatDouble != null && storeLngDouble != null;
  bool get hasDestPosition => destLatDouble != null && destLngDouble != null;

  static ActiveOrderEntity fromFirestore(
    Map<String, dynamic> data,
    String orderId,
  ) {
    final startedAtRaw = data['startedAt'];
    DateTime? startedAt;
    if (startedAtRaw is Timestamp) {
      startedAt = startedAtRaw.toDate();
    }

    return ActiveOrderEntity(
      orderId: orderId,
      documentExists: true,
      driverId: data['driverId'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      driverToken: data['driverToken'] as String? ?? '',
      userToken: data['userToken'] as String? ?? '',
      storeName: data['storeName'] as String? ?? '',
      storeAddress: data['storeAddress'] as String? ?? '',
      storeImage: data['storeImage'] as String? ?? '',
      storeLat: data['storeLat'] as String?,
      storeLng: data['storeLng'] as String?,
      driverName: data['driverName'] as String?,
      userName: data['userName'] as String? ?? '',
      userImage: data['userImage'] as String? ?? '',
      userAddress: data['userAddress'] as String? ?? '',
      destLat: data['destLat'] as String?,
      destLng: data['destLng'] as String?,
      totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0,
      status: data['status'] as String? ?? '',
      startedAt: startedAt,
      long: data['long'] as String?,
      lat: data['lat'] as String?,
      city: data['city'] as String?,
      street: data['street'] as String?,
      phone: data['phone'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    orderId,
    driverId,
    userId,
    driverToken,
    userToken,
    storeName,
    storeAddress,
    storeImage,
    storeLat,
    storeLng,
    driverName,
    userName,
    userImage,
    userAddress,
    destLat,
    destLng,
    totalPrice,
    status,
    startedAt,
    long,
    lat,
    city,
    street,
    phone,
    documentExists,
  ];
}
