import 'package:equatable/equatable.dart';

class ProductTypeEntity extends Equatable {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isSuperAdmin;

  const ProductTypeEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  @override
  List<Object?> get props => [id, name, slug, image, isSuperAdmin];
}
