import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/checkout/presentation/view/widgets/address_item.dart';
import 'package:flower_app/features/checkout/presentation/view_model/check_out_cupit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_events.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  int? selectedIndex;

  final checkoutCubit = getIt.get<CheckoutCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutCubit>(
      create: (context) {
        final cubit = checkoutCubit;
        cubit.doIntent(GetUserAddressesEvents());
        return cubit;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        appBar: AppBar(
          title: Text("Checkout".tr(), style: context.appTheme.medium20).tr(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _sectionContainer(
                context: context,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery time",
                          style: context.appTheme.medium16.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Schedule",
                          style: context.appTheme.medium16.copyWith(
                            color: context.appTheme.primary[50],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.access_time),
                        ),
                        Text("Instant, ", style: context.appTheme.medium16),
                        Expanded(
                          child: Text(
                            "Arrive by 03 Sep 2024, 11:00 AM",
                            style: context.appTheme.medium16.copyWith(
                              color: context.appTheme.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              BlocConsumer<CheckoutCubit, CheckoutStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  // Error state
                  if (state.addressState?.errorMessage != null &&
                      state.addressState!.errorMessage!.isNotEmpty) {
                    return const Text("NoDATA");
                  }

                  // Loading state
                  if (state.addressState?.isLoading ?? true) {
                    return Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScale,
                          colors: context.appTheme.kDefaultRainbowColors,
                          strokeWidth: 1,
                          backgroundColor: context.appTheme.backgroundColor,
                          pathBackgroundColor: Colors.black,
                        ),
                      ),
                    );
                  }

                  // Empty state
                  final addresses = state.addressState?.data ?? [];
                  if (addresses.isEmpty) {
                    return Center(
                      child: Text(
                        "There are no addresses yet",
                        style: context.appTheme.medium20,
                      ).tr(),
                    );
                  }

                  // Success state with data
                  final selectedIndex = state.selectedAddress;

                  return _sectionContainer(
                    context: context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery address",
                          style: context.appTheme.medium16.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        RadioGroup<String>(
                          groupValue: selectedIndex?.toString(),
                          onChanged: (value) {
                            if (value != null) {
                              final index = int.parse(value);

                              context.read<CheckoutCubit>().doIntent(
                                SelectAddressEvents(selectedAddresses: index),
                              );
                            }
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addresses.length,
                            itemBuilder: (context, index) {
                              final address = addresses[index];
                              return AddressItem(
                                address: address.city ?? "No city",
                                title: address.street ?? "No street",
                                isSelected: selectedIndex == index,
                                value: index.toString(),
                                onEdit: () {
                                  // Handle edit
                                },
                                onTap: () {
                                  context.read<CheckoutCubit>().doIntent(
                                    SelectAddressEvents(
                                      selectedAddresses: index,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionContainer({
    required Widget child,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white),
      child: child,
    );
  }
}
