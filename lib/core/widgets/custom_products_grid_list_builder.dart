import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/app/presentation/widget/custom_card.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/widgets/custom_image_view.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomProductsGridListBuilder extends StatelessWidget {
  final ScrollController? scrollController;
  final List<ProductsEntity>? products;
  final void Function(ProductsEntity)? onProductTap;

  const CustomProductsGridListBuilder({
    super.key,
    required this.products,
    this.scrollController,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) =>
      (products != null && products!.isNotEmpty)
      ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.54,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          itemCount: products?.length ?? 0,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => onProductTap?.call(products![index]),
            child: CustomCard(
              product: products![index],
              onTap: products![index].outOfStock
                  ? null
                  : () {
                      context.read<OrderViewModel>().doIntent(
                        AddItemToCart(product: products![index]),
                      );
                    },
            ),
          ),
        )
      : const NoProductsView();
}

class NoProductsView extends StatelessWidget {
  const NoProductsView({super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: CustomImageView(
          imagePath: "assets/image/img_sold_out.png",
          color: context.appTheme.primary,
        ),
      ),
      context.h(16),
      Text(
        "no_products_found".tr(),
        textAlign: TextAlign.center,
        style: context.appTheme.semiBold18.copyWith(
          color: context.appTheme.grey,
        ),
      ),
    ],
  );
}
