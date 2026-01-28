import 'package:flower_app/features/checkout/data/models/response/check_out_order_response.dart';

class SessionEntity {
  final String? id;
  final String? object;
  final AdaptivePricing? adaptivePricing;
  final dynamic afterExpiration;
  final dynamic allowPromotionCodes;
  final int? amountSubtotal;
  final int? amountTotal;
  final AutomaticTax? automaticTax;
  final dynamic billingAddressCollection;
  final BrandingSettings? brandingSettings;
  final String? cancelUrl;
  final String? clientReferenceId;
  final dynamic clientSecret;
  final CollectedInformation? collectedInformation;
  final dynamic consent;
  final dynamic consentCollection;
  final int? created;
  final String? currency;
  final dynamic currencyConversion;
  final List<dynamic>? customFields;
  final CustomText? customText;
  final dynamic customer;
  final dynamic customerAccount;
  final String? customerCreation;
  final CustomerDetails? customerDetails;
  final String? customerEmail;
  final List<dynamic>? discounts;
  final int? expiresAt;
  final dynamic invoice;
  final InvoiceCreation? invoiceCreation;
  final bool? liveMode;
  final dynamic locale;
  final Metadata? metadata;
  final String? mode;
  final dynamic originContext;
  final dynamic paymentIntent;
  final dynamic paymentLink;
  final String? paymentMethodCollection;
  final PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;
  final PaymentMethodOptions? paymentMethodOptions;
  final List<String>? paymentMethodTypes;
  final String? paymentStatus;
  final dynamic permissions;
  final PhoneNumberCollection? phoneNumberCollection;
  final dynamic recoveredFrom;
  final dynamic savedPaymentMethodOptions;
  final dynamic setupIntent;
  final dynamic shippingAddressCollection;
  final dynamic shippingCost;
  final dynamic shippingDetails;
  final List<dynamic>? shippingOptions;
  final String? status;
  final dynamic submitType;
  final dynamic subscription;
  final String? successUrl;
  final TotalDetails? totalDetails;
  final String? uiMode;
  final String? url;
  final dynamic walletOptions;

  SessionEntity({
    this.id,
    this.object,
    this.adaptivePricing,
    this.afterExpiration,
    this.allowPromotionCodes,
    this.amountSubtotal,
    this.amountTotal,
    this.automaticTax,
    this.billingAddressCollection,
    this.brandingSettings,
    this.cancelUrl,
    this.clientReferenceId,
    this.clientSecret,
    this.collectedInformation,
    this.consent,
    this.consentCollection,
    this.created,
    this.currency,
    this.currencyConversion,
    this.customFields,
    this.customText,
    this.customer,
    this.customerAccount,
    this.customerCreation,
    this.customerDetails,
    this.customerEmail,
    this.discounts,
    this.expiresAt,
    this.invoice,
    this.invoiceCreation,
    this.liveMode,
    this.locale,
    this.metadata,
    this.mode,
    this.originContext,
    this.paymentIntent,
    this.paymentLink,
    this.paymentMethodCollection,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.paymentStatus,
    this.permissions,
    this.phoneNumberCollection,
    this.recoveredFrom,
    this.savedPaymentMethodOptions,
    this.setupIntent,
    this.shippingAddressCollection,
    this.shippingCost,
    this.shippingDetails,
    this.shippingOptions,
    this.status,
    this.submitType,
    this.subscription,
    this.successUrl,
    this.totalDetails,
    this.uiMode,
    this.url,
    this.walletOptions,
  });
}
