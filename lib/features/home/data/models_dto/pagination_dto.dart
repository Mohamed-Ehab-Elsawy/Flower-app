import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

@JsonSerializable()
class PaginationDto {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  PaginationDto({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory PaginationDto.fromJson(Map<String, dynamic> json) {
    return _$PaginationDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaginationDtoToJson(this);
  }
}
