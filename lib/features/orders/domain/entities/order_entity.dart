import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';

const double deliveryFee = 10.0;

// API Response Entity
class CartResponseEntity extends Equatable {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const CartResponseEntity({this.message, this.numOfCartItems, this.cart});
  @override
  List<Object?> get props => [message, numOfCartItems, cart];
}

// Cart Entity
class CartEntity extends Equatable {
  final String? id;
  final String? userId;
  final List<CartItemEntity>? items;
  final List<String>? appliedCoupons;
  final double? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CartEntity({
    this.id,
    this.userId,
    this.items,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  double get totalPriceWithDelivery => deliveryFee + subTotal;

  double get subTotal => totalPrice ?? 0;
  double get getDeliveryFee => deliveryFee;

  @override
  List<Object?> get props => [
    id,
    userId,
    items,
    appliedCoupons,
    totalPrice,
    createdAt,
    updatedAt,
  ];
}

// Cart Item Entity
class CartItemEntity extends Equatable {
  final String? id;
  final ProductsEntity? product;
  final double? price;
  final int? quantity;

  const CartItemEntity({this.id, this.product, this.price, this.quantity});
  CartItemEntity copyWith({
    String? id,
    ProductsEntity? product,
    double? price,
    int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      product: product ?? this.product,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  // Calculate total price for this item
  double get totalPrice => (price ?? product?.price ?? 0) * (quantity ?? 0);

  // Check if price is valid (has either direct price or product price)
  bool get hasValidPrice => (price ?? product?.price) != null;

  // Get the effective unit price (prefers direct price over product price)
  double get unitPrice => price ?? product?.price ?? 0;

  // Format price with currency symbol
  String get formattedTotalPrice => 'EGP ${totalPrice.toStringAsFixed(2)}';

  // Helper methods for quantity operations
  CartItemEntity increment() => copyWith(quantity: (quantity ?? 0) + 1);

  CartItemEntity decrement() {
    final currentQty = quantity ?? 0;
    return copyWith(quantity: currentQty > 1 ? currentQty - 1 : 1);
  }

  // Validate if item can be decremented
  bool get canDecrement => (quantity ?? 0) > 1;

  // Check if item is valid (has product and quantity)
  bool get isValid => product != null && (quantity ?? 0) > 0;

  // Calculate price difference between two quantities
  double priceDifferenceForQuantity(int newQuantity) {
    final currentQty = quantity ?? 0;
    final unitPriceValue = unitPrice;
    return (newQuantity - currentQty) * unitPriceValue;
  }

  @override
  List<Object?> get props => [id, product, price, quantity];
}
