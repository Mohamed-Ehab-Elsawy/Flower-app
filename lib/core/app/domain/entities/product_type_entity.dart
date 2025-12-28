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
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
  });

  @override
  List<Object?> get props => [id, name, slug, image, isSuperAdmin];
}
