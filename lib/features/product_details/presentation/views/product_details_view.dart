import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/core/widgets/custom_image_view.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductsEntity product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void didChangeDependencies() {
    context
        .read<OrderViewModel>()
        .uiEventsStream
        .listen((event) {
      switch (event) {
        case AddToCartEvent():
        //show toast
          if (!mounted) return;
          Toast.showToast(context, "Product added to cart");
        case UnAuthorizedEvent():
        //show toast
          if (!mounted) return;
          Toast.shodDialog(context: context, title: event.errorMessage,);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images;
    final isInStock = widget.product.quantity! > 0;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: 360,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      itemCount: images!.length,
                      itemBuilder: (context, index) {
                        return CustomImageView(
                          imagePath: images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: _buildIndicatorWidget(images.length),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${"EGP".tr()} ${widget.product.price}",
                          style: context.appTheme.medium20.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "status".tr(),
                                style: context.appTheme.medium16,
                              ),
                              TextSpan(
                                text: isInStock
                                    ? "inStock".tr()
                                    : "outOfStock".tr(),
                                style: context.appTheme.regular14.copyWith(
                                  color: isInStock
                                      ? context.appTheme.success
                                      : context.appTheme.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "allPricesIncludeTax".tr(),
                      style: context.appTheme.regular12.copyWith(
                        color: context.appTheme.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.product.title ?? "",
                      style: context.appTheme.medium16,
                    ),
                    const SizedBox(height: 24),
                    Text("description".tr(), style: context.appTheme.medium16),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.description ?? "",
                      style: context.appTheme.regular14,
                    ),

                    const SizedBox(height: 24),
                    Text(
                      "bouquetInclude".tr(),
                      style: context.appTheme.medium16,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${"quantity".tr()}: ${widget.product.quantity}",
                      style: context.appTheme.regular14,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: isInStock
                          ? () {
                              context.read<OrderViewModel>().doIntent(
                                AddItemToCart(product: widget.product),
                              );
                            }
                          : null,
                      child: Text("addToCart".tr()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorWidget(int images) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        images,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? context.appTheme.primary
                : context.appTheme.secondary[70],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
