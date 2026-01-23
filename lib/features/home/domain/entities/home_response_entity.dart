// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';

class HomeResponseEntity extends Equatable {
  final String? message;
  final List<ProductsEntity>? products;
  final List<ProductTypeEntity>? categories;
  final List<ProductsEntity>? bestSeller;
  final List<ProductTypeEntity>? occasions;
  const HomeResponseEntity({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  @override
  List<Object?> get props => [
    message,
    products,
    categories,
    bestSeller,
    occasions,
  ];
}
