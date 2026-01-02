import 'package:flower_app/core/app/presentation/widget/custom_card.dart';
import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.53,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            return const CustomCard(
              title: "Loading Name",
              imageUrl: IAppText.placeHolderImage,
              price: 0,
            );
          },
        ),
      ),
    );
  }
}
