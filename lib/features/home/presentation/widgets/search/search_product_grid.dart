import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/app/presentation/widget/custom_card.dart';
import 'package:flutter/material.dart';

class SearchProductsGrid extends StatelessWidget {
  final List<ProductsEntity> products;
  final Function(ProductsEntity) onProductTap;

  const SearchProductsGrid({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.54,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return CustomCard(
          product: product,
          onTap: product.outOfStock ? null: () => onProductTap(product),
        );
      },
    );
  }
}