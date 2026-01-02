// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';

class HomeResponseEntity extends Equatable {
  String? message;
  List<ProductsEntity>? products;
  List<ProductTypeEntity>? categories;
  List<ProductsEntity>? bestSeller;
  List<ProductTypeEntity>? occasions;
  HomeResponseEntity({
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
