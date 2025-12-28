import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double? oldPrice;
  final int? discountPercentage;
  final VoidCallback? onAddToCart;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.oldPrice,
    this.discountPercentage,
    this.onAddToCart,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: context.appTheme.secondary,
          border: Border.all(color: context.appTheme.surface.shade100),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: context.appTheme.surface.shade100.withAlpha(05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(

              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: CustomImageView(imagePath: imageUrl),
              ),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'EGP $price',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                context.w(8),
                if (oldPrice != null)
                  Text(
                    '$oldPrice',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                context.w(10),
                if (discountPercentage != null)
                  Text(
                    '$discountPercentage%',
                    style: context.appTheme.regular14.copyWith(
                      color: context.appTheme.success,
                    ),
                    textAlign: TextAlign.start,
                  ),
              ],
            ),
            context.h(8),

            ElevatedButton(
              onPressed: () {
                onAddToCart;
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  Text(
                    'Add to cart',
                    style: context.appTheme.medium13.copyWith(
                      color: context.appTheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
