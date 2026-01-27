import '../../data/models/response/order_dto.dart';

class OrderEntity {
  final String? user;
  final List<OrderItems>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? Id;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? V;

  OrderEntity({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.Id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.V,
  });
}
