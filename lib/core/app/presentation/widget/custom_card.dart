import 'package:easy_localization/easy_localization.dart';
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
          color: Colors.transparent,
          border: Border.all(color: context.appTheme.grey.withAlpha(30)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: context.appTheme.surface.shade100.withAlpha(05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Expanded(
          flex: 55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: imageUrl,
                radius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Expanded(
                flex: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    context.h(8),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.appTheme.regular12,
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 5,
                      children: [
                        Text(
                          'EGP'.tr(args: [price.toString()]),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        if (oldPrice != null)
                          Text(
                            '$oldPrice',
                            style: context.appTheme.regular14.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),

                        if (discountPercentage != null)
                          Text(
                            '$discountPercentage%',
                            style: context.appTheme.regular14.copyWith(
                              color: context.appTheme.success,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.start,
                          ),
                      ],
                    ),
                    context.h(8),

                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          onAddToCart;
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_cart_outlined),
                            Text(
                              'addToCart'.tr(),
                              style: context.appTheme.medium13.copyWith(
                                color: context.appTheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
