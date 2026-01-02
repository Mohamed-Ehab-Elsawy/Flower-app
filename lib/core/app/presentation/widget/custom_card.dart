import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final ProductsEntity product;

  const CustomCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: context.appTheme.secondary.withAlpha(0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: CustomImageView(
                imagePath: product.imageCover,
                radius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  context.h(8),
                  Text(
                    product.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.appTheme.regular12,
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 5,
                    children: [
                      Text(
                        '${'EGP '.tr()}${product.priceAfterDiscount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.appTheme.surface,
                        ),
                      ),

                      if (product.price != null)
                        Text(
                          '${product.price}',
                          style: context.appTheme.regular14.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: context.appTheme.secondary[80],
                            fontSize: 12,
                          ),
                        ),

                      // if (product.percentageDiscount != null)
                      //   Text(
                      //     '$discountPercentage%',
                      //     style: context.appTheme.regular14.copyWith(
                      //       color: context.appTheme.success,
                      //       fontSize: 12,
                      //     ),
                      //     textAlign: TextAlign.start,
                      //   ),
                    ],
                  ),
                  context.h(8),

                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //TODO: Add to Cart
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: Text(
                        'addToCart'.tr(),
                        style: context.appTheme.medium13.copyWith(
                          color: context.appTheme.secondary,
                        ),
                      ),
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
