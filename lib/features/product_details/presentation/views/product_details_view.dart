import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductsEntity product;
  const ProductDetailsView({super.key,required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final List<String> _images = widget.product.images??[];
  late final isInStock = (widget.product.quantity ?? 0) > 0;


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appTheme.lightPink,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 340,
              child: Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: CustomImageView(
                          imagePath: _images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            _buildPageIndicators(),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${"EGP".tr()} ${widget.product.price}",style: context.appTheme.medium20.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                          RichText(text:
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "status".tr(),
                                style: context.appTheme.medium16,
                              ),
                              TextSpan(
                                text: isInStock ? "inStock".tr() : "outOfStock".tr(),
                                style: context.appTheme.regular14.copyWith(
                                  color: isInStock ? context.appTheme.success : context.appTheme.error,
                                ),
                              ),
                            ]
                          )),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text("allPricesIncludeTax".tr(),style:context.appTheme.regular12.copyWith(
                        color: context.appTheme.grey,
                      ),),
                      const SizedBox(height: 8),
                      Text(widget.product.title ?? "",style: context.appTheme.medium16.copyWith(
                        color: context.appTheme.surface
                      )),
                      const SizedBox(height: 24),
                      Text("description".tr(),style: context.appTheme.medium16),
                      const SizedBox(height: 8),
                      Text(widget.product.description ??"",style: context.appTheme.regular14),
                      const SizedBox(height: 24),
                      Text("bouquetInclude".tr(),style: context.appTheme.medium16),
                      const SizedBox(height: 8),
                      Text("${"quantity".tr()}: ${widget.product.quantity ?? 0}",style: context.appTheme.regular14),
                      const SizedBox(height: 2),
                      Text("whiteWrap".tr(),style: context.appTheme.regular14),
                      const SizedBox(height: 24),
                      ElevatedButton(onPressed: (){}, child: Text("addToCart".tr()))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _images.length,
              (index) => GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedContainer(
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
        ),
      ),
    );
  }
}