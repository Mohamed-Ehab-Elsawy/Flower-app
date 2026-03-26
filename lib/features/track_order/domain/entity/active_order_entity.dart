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
  final String? storeLatLong;
  final String? storePhoneNumber;

  final String? driverImage;
  final String? driverPhoneNumber;
  final String? driverName;

  final String userName;
  final String userImage;
  final String userAddress;
  final String? userPhoneNumber;

  final double totalPrice;

  final String status;

  final DateTime? startedAt;
  final String? long;
  final String? lat;
  final String? city;
  final String? street;
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
    this.storeLatLong,
    this.storePhoneNumber,
    this.driverName,
    this.userName = '',
    this.userImage = '',
    this.userAddress = '',
    this.userPhoneNumber,
    this.totalPrice = 0,
    this.status = '',
    this.startedAt,
    this.long,
    this.lat,
    this.city,
    this.street,
    required this.documentExists,
    this.driverImage = '',
    this.driverPhoneNumber = '',
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

  String? get phone {
    if (storePhoneNumber?.isNotEmpty == true) return storePhoneNumber;
    if (userPhoneNumber?.isNotEmpty == true) return userPhoneNumber;
    return null;
  }

  List<double?> get _userLatLng {
    final raw = storeLatLong?.trim();
    if (raw == null || raw.isEmpty) return const [null, null];
    final parts = raw.split(',');
    if (parts.length != 2) return const [null, null];
    final lat = double.tryParse(parts[0].trim());
    final lng = double.tryParse(parts[1].trim());
    return [lat, lng];
  }

  double? get userLatDouble => _userLatLng[0];
  double? get userLngDouble => _userLatLng[1];
  bool get hasUserPosition => userLatDouble != null && userLngDouble != null;

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
      storeLatLong: data['storeLatLong'] as String?,
      storePhoneNumber: data['storePhoneNumber'] as String?,
      driverName: data['driverName'] as String?,
      userName: data['userName'] as String? ?? '',
      userImage: data['userImage'] as String? ?? '',
      userAddress: data['userAddress'] as String? ?? '',
      userPhoneNumber: data['userPhoneNumber'] as String?,
      totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0,
      status: data['status'] as String? ?? '',
      startedAt: startedAt,
      long: _asString(data['long']),
      lat: _asString(data['lat']),
      city: data['city'] as String?,
      street: data['street'] as String?,
      driverImage: data['driverImage'] as String?,
      driverPhoneNumber: data['driverPhoneNumber'] as String?,
    );
  }

  static String? _asString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
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
    storeLatLong,
    storePhoneNumber,
    driverName,
    userName,
    userImage,
    userAddress,
    userPhoneNumber,
    totalPrice,
    status,
    startedAt,
    long,
    lat,
    city,
    street,
    driverImage,
    driverPhoneNumber,
    documentExists,
  ];
}
