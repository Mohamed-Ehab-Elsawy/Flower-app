import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/presentation/models/payment_method_model.dart';
import 'package:flower_app/features/checkout/presentation/view/widgets/address_item.dart';
import 'package:flower_app/features/checkout/presentation/view/widgets/payment_widget.dart';
import 'package:flower_app/features/checkout/presentation/view_model/check_out_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_events.dart';
import 'package:flower_app/features/checkout/presentation/view_model/checkout_state.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
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
  late CartEntity card;
  final checkoutCubit = getIt.get<CheckoutCubit>();

  @override
  void initState() {
    super.initState();
    checkoutCubit.checkoutUiEvent.listen((event) {
      switch (event) {
        case ShowToast():
          {
            if (!mounted) return;
            Toast.showToast(context, event.message, isError: event.isError);
          }
        case NavigateToHome():
          {
            if (!mounted) return;
            Navigator.pushNamed(context, AppRoutes.appSection);
          }
        case NavigateToPayment():
          {
            if (!mounted) return;
            Navigator.pushNamed(
              context,
              AppRoutes.payment,
              arguments: checkoutCubit.state.checkoutCreditCardState?.data,
            );
          }
        case NavigateToAddress():
          {
            if (!mounted) return;
            Navigator.pushNamed(context, AppRoutes.saveAddress);
          }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is CartEntity) {
      card = args;
    } else {
      card = const CartEntity();
    }
  }

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
          backgroundColor: context.appTheme.backgroundColor,
          elevation: 0,
          title: Text("Checkout", style: context.appTheme.medium20).tr(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
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
                        ).tr(),
                        Text(
                          "Schedule",
                          style: context.appTheme.medium16.copyWith(
                            color: context.appTheme.primary[50],
                            fontSize: 18,
                          ),
                        ).tr(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.access_time),
                        ),
                        Text(
                          "Instant, ",
                          style: context.appTheme.medium16,
                        ).tr(),
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
                  if (state.addressState?.errorMessage != null &&
                      state.addressState!.errorMessage!.isNotEmpty) {
                    return const Text("No Address").tr();
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
                        ).tr(),
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
                                address: address.city ?? "No city".tr(),
                                title: address.street ?? "No street".tr(),
                                isSelected: selectedIndex == index,
                                value: index.toString(),
                                onEdit: () {
                                  checkoutCubit.doEvent(NavigateToAddress());
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

              _sectionContainer(
                context: context,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appTheme.backgroundColor,
                    side: const BorderSide(color: Colors.black38, width: 1),
                  ),

                  onPressed: () {
                    checkoutCubit.doEvent(NavigateToAddress());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: context.appTheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        "Add new",
                        style: context.appTheme.medium13.copyWith(
                          fontSize: 14,
                          color: context.appTheme.primary,
                        ),
                      ).tr(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<CheckoutCubit, CheckoutStates>(
                builder: (context, state) {
                  return _sectionContainer(
                    context: context,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment method",
                          style: context.appTheme.medium16.copyWith(
                            fontSize: 18,
                          ),
                        ).tr(),
                        const SizedBox(height: 16),
                        RadioGroup<PaymentMethodModel>(
                          groupValue: state.selectedPaymentMethod,
                          onChanged: (PaymentMethodModel? newValue) {
                            if (newValue == null) return;
                            checkoutCubit.doIntent(
                              SelectedPaymentEvents(
                                selectedPaymentMethod: newValue,
                              ),
                            );
                          },
                          child: PaymentWidget(
                            selectedMethod: state.selectedPaymentMethod,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _sectionContainer(
                context: context,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub Total",
                          style: context.appTheme.regular16.copyWith(
                            color: context.appTheme.grey,
                          ),
                        ).tr(),
                        Text(
                          "${card.totalPrice}\$",
                          style: context.appTheme.regular16.copyWith(
                            color: context.appTheme.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Fee",
                          style: context.appTheme.regular16.copyWith(
                            color: context.appTheme.grey,
                          ),
                        ).tr(),
                        Text(
                          "${card.getDeliveryFee}\$",
                          style: context.appTheme.regular16.copyWith(
                            color: context.appTheme.grey,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: context.appTheme.grey,
                      thickness: 1,
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: context.appTheme.medium16.copyWith(
                            fontSize: 18,
                          ),
                        ).tr(),
                        Text(
                          "${card.totalPriceWithDelivery}\$",
                          style: context.appTheme.medium16.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    BlocConsumer<CheckoutCubit, CheckoutStates>(
                      listener: (context, state) {
                        final cashState = state.checkoutCashState;
                        final cardState = state.checkoutCreditCardState;

                        if (cashState == null && cardState == null) {
                          return;
                        }
                        final hasError =
                            (cashState?.errorMessage != null &&
                                cashState!.errorMessage!.isNotEmpty) ||
                            (cardState?.errorMessage != null &&
                                cardState!.errorMessage!.isNotEmpty);

                        if (hasError) {
                          final errorMessage =
                              cashState?.errorMessage ??
                              cardState?.errorMessage ??
                              '';
                          checkoutCubit.doEvent(
                            ShowToast(message: errorMessage, isError: true),
                          );
                          return;
                        }

                        if (cashState?.data != null) {
                          checkoutCubit.doEvent(
                            ShowToast(
                              message: "Order confirmed".tr(),
                              isError: false,
                            ),
                          );
                          checkoutCubit.doEvent(NavigateToHome());

                          return;
                        }

                        if (cardState?.data != null) {
                          checkoutCubit.doEvent(
                            ShowToast(
                              message: "Complete the payment information".tr(),
                              isError: false,
                            ),
                          );
                          checkoutCubit.doEvent(NavigateToPayment());
                        }
                      },

                      builder: (context, state) {
                        final bool isAddressSelected =
                            state.selectedAddress != null;
                        final bool isPaymentMethodSelected =
                            state.selectedPaymentMethod != null;
                        final bool canPlaceOrder =
                            isAddressSelected && isPaymentMethodSelected;

                        return SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 08,
                              right: 08,
                              bottom: 18,
                              top: 18,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: canPlaceOrder
                                    ? context.appTheme.primary
                                    : context.appTheme.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: canPlaceOrder
                                  ? () {
                                      CheckOutOrderRequest checkOutRequest =
                                          CheckOutOrderRequest(
                                            shippingAddress: ShippingAddress(
                                              phone: checkoutCubit
                                                  .state
                                                  .addressState!
                                                  .data?[checkoutCubit
                                                      .state
                                                      .selectedAddress!]
                                                  .phone,
                                              street: checkoutCubit
                                                  .state
                                                  .addressState!
                                                  .data?[checkoutCubit
                                                      .state
                                                      .selectedAddress!]
                                                  .street,
                                              lat: checkoutCubit
                                                  .state
                                                  .addressState!
                                                  .data?[checkoutCubit
                                                      .state
                                                      .selectedAddress!]
                                                  .lat,
                                              long: checkoutCubit
                                                  .state
                                                  .addressState!
                                                  .data?[checkoutCubit
                                                      .state
                                                      .selectedAddress!]
                                                  .long,
                                              city: checkoutCubit
                                                  .state
                                                  .addressState!
                                                  .data?[checkoutCubit
                                                      .state
                                                      .selectedAddress!]
                                                  .city,
                                            ),
                                          );
                                      if (checkoutCubit
                                              .state
                                              .selectedPaymentMethod ==
                                          PaymentMethodModel.cash) {
                                        checkoutCubit.doIntent(
                                          CheckoutCashStateEvents(
                                            checkOutRequest: checkOutRequest,
                                          ),
                                        );
                                      } else if (checkoutCubit
                                              .state
                                              .selectedPaymentMethod ==
                                          PaymentMethodModel.card) {
                                        checkoutCubit.doIntent(
                                          CheckoutCreditCardEvents(
                                            checkOutRequest: checkOutRequest,
                                          ),
                                        );
                                      }
                                    }
                                  : null,
                              child: Text(
                                "Place order",
                                style: context.appTheme.medium16.copyWith(
                                  fontSize: 18,
                                  color: canPlaceOrder
                                      ? context.appTheme.backgroundColor
                                      : Colors.white70,
                                ),
                              ).tr(),
                            ),
                          ),
                        );
                      },
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
