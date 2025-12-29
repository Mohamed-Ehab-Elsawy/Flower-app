import 'package:flower_app/features/home/data/models_dto/pagination_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/app/data/models/product_dto.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final PaginationDto? paginationDto;
  @JsonKey(name: "products")
  final List<ProductDto>? productsDto;

  ProductResponse({this.message, this.paginationDto, this.productsDto});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductResponseToJson(this);
  }
}
