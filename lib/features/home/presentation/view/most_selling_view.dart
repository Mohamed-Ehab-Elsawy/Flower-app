import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/presentation/widget/custom_card.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MostSellingView extends StatelessWidget {
  const MostSellingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("mostSelling".tr(), style: context.appTheme.medium20),
            Text(
              "Bloom with our exquisite best sellers".tr(),
              style: context.appTheme.medium13.copyWith(
                color: context.appTheme.surface[40],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.54,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            return CustomCard(
              title: "Bloom with our exquisite best sellers",
              imageUrl: "assets/images/flower.png",

              onTap: () {},
              price: 20,
            );
          },
        ),
      ),
    );
  }
}
