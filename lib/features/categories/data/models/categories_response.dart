import 'package:flower_app/core/app/data/models/product_type_dto.dart';
import 'package:flower_app/core/app/data/models/meta_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "categories")
  final List<ProductTypeDto>? categories;

  CategoriesResponse ({
    this.message,
    this.metadata,
    this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesResponseToJson(this);
  }
}
