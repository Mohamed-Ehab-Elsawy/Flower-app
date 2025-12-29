// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flower_app/core/app/data/models/product_dto.dart';
import 'package:flower_app/core/app/data/models/product_type_dto.dart';

part 'home_response_dto.g.dart';

@JsonSerializable()
class HomeResponseDto extends Equatable {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'products')
  List<ProductDto>? products;
  @JsonKey(name: 'categories')
  List<ProductTypeDto>? categories;
  @JsonKey(name: 'bestSeller')
  List<ProductDto>? bestSeller;
  @JsonKey(name: 'occasions')
  List<ProductTypeDto>? occasions;
  HomeResponseDto({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseDtoToJson(this);

  @override
  List<Object?> get props => [
    message,
    products,
    categories,
    bestSeller,
    occasions,
  ];
}
