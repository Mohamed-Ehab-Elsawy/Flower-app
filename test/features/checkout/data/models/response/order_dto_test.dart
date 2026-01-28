import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OrderDto orderDto;

  test('test  toEntity method should return OrderEntity with same value', () {
    orderDto = OrderDto(
      createdAt: "createdAt",
      id: "id",
      updatedAt: "updatedAt",
      V: 0,
      orderNumber: "orderNumber",
      isPaid: false,
      isDelivered: false,
      orderItems: [OrderItems(price: 0, quantity: 0, id: "id")],
      paymentType: "paymentType",
      state: "state",
      totalPrice: 0,
      user: "user",
    );
    final result = orderDto.toEntity();
    expect(result.createdAt, equals(orderDto.createdAt));
    expect(result.id, equals(orderDto.id));
    expect(result.V, equals(orderDto.V));
    expect(result.isPaid, equals(orderDto.isPaid));
    expect(result.isDelivered, equals(orderDto.isDelivered));
    expect(result.orderItems?.length, equals(orderDto.orderItems?.length));
    expect(result.paymentType, equals(orderDto.paymentType));
    expect(result.state, equals(orderDto.state));
    expect(result.totalPrice, equals(orderDto.totalPrice));
    expect(result.user, equals(orderDto.user));
    expect(result.updatedAt, equals(orderDto.updatedAt));
    expect(result.orderNumber, equals(orderDto.orderNumber));
  });
  test(
    'test  toEntity method with null value should return OrderEntity with null value',
    () {
      orderDto = OrderDto(
        createdAt: null,
        id: null,
        updatedAt: null,
        V: null,
        orderNumber: null,
        isPaid: null,
        isDelivered: null,
        paymentType: null,
        state: null,
        totalPrice: null,
        user: null,
      );
      final result = orderDto.toEntity();
      expect(result.createdAt, isNull);
      expect(result.id, isNull);
      expect(result.V, isNull);
      expect(result.isPaid, isNull);
      expect(result.isDelivered, isNull);
      expect(result.orderItems?.length, isNull);
      expect(result.paymentType, isNull);
      expect(result.state, isNull);
      expect(result.totalPrice, isNull);
      expect(result.user, isNull);
      expect(result.updatedAt, isNull);
      expect(result.orderNumber, isNull);
    },
  );
}
