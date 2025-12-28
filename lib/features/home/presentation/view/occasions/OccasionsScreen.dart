import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_cubit.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_events.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_states.dart';
import 'package:flower_app/features/home/presentation/view/occasions/tab_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/presentation/widget/custom_card.dart';
import 'ocassion_model.dart';

class OccasionScreen extends StatefulWidget {
  const OccasionScreen({super.key});

  @override
  State<OccasionScreen> createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  final occasionsCubit = getIt.get<OccasionsCubit>();
  late List<OcassionModel> occasions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is List<OcassionModel>) {
      occasions = args;
      print("Occasions length: ${occasions.length}"); // لازم يطبع 2
    } else {
      occasions = [];
      print("No arguments received");
    }
  }

  @override
  Widget build(BuildContext context) {
    // occasionsCubit.occasionId = args.id! ;
    return BlocProvider<OccasionsCubit>(
      create: (context) => occasionsCubit
        ..doIntent(
          GetAllProductsByOccasionsEvents(
            occasionId: occasionsCubit.occasionId ?? "673b34c21159920171827ae0",
          ),
        ),
      child: Scaffold(
        appBar: AppBar(title: const Text("Occasion")),
        body: Column(
          children: [
            DefaultTabController(
              length: occasions.length,
              child: TabBar(
                isScrollable: true,
                onTap: (index) {
                  //// HomeCubit.get(context).changeSources(index) ;
                },
                indicator: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.green,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                tabs: occasions
                    .map((occasions) => Tab(
                  child: Text(
                    occasions.name ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ))
                    .toList(),
              ),
            ),
            BlocBuilder<OccasionsCubit, OccasionsStates>(
              builder: (context, state) {
                if (state.productsStates?.errorMessage != null &&
                    state.productsStates!.errorMessage!.isNotEmpty) {
                  return Text(state.productsStates!.errorMessage!);
                } else if (!(state.productsStates?.isLoading ?? false) &&
                    state.productsStates?.data != null &&
                    state.productsStates!.data!.isNotEmpty) {
                  final products = state.productsStates?.data ?? [];
                  if (products.isEmpty) {
                    return const Center(child: Text("لا توجد منتجات متاحة"));
                  }
                  return  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,              // عمودين
                        childAspectRatio: 0.75,         // نسبة العرض للارتفاع (تعدلها حسب التصميم)
                        mainAxisSpacing: 16,            // مسافة رأسية
                        crossAxisSpacing: 16,           // مسافة أفقية
                      ),                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final products = state.productsStates?.data ?? [];


                        final product = products[index];
                        return InkWell(
                          onTap: () {},
                          child: CustomCard(
                            title: product.title ?? "",
                            imageUrl: product.imgCover!,
                            price: product.price?.toDouble() ?? 0,
                          ),
                        );
                      },
                      itemCount: state.productsStates!.data!.length,                    ),
                  );
                } else if (!(state.productsStates?.isLoading ?? false) &&
                    state.productsStates?.data != null &&
                    state.productsStates!.data!.isEmpty) {
                  return Text("AppStrings.noDate");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
