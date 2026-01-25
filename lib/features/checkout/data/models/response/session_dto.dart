import 'package:flower_app/features/checkout/data/models/response/check_out_order_response.dart';
import 'package:flower_app/features/checkout/domain/entity/sessionEntity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "object")
  final String? object;
  @JsonKey(name: "adaptive_pricing")
  final AdaptivePricing? adaptivePricing;
  @JsonKey(name: "after_expiration")
  final dynamic afterExpiration;
  @JsonKey(name: "allow_promotion_codes")
  final dynamic allowPromotionCodes;
  @JsonKey(name: "amount_subtotal")
  final int? amountSubtotal;
  @JsonKey(name: "amount_total")
  final int? amountTotal;
  @JsonKey(name: "automatic_tax")
  final AutomaticTax? automaticTax;
  @JsonKey(name: "billing_address_collection")
  final dynamic billingAddressCollection;
  @JsonKey(name: "branding_settings")
  final BrandingSettings? brandingSettings;
  @JsonKey(name: "cancel_url")
  final String? cancelUrl;
  @JsonKey(name: "client_reference_id")
  final String? clientReferenceId;
  @JsonKey(name: "client_secret")
  final dynamic clientSecret;
  @JsonKey(name: "collected_information")
  final CollectedInformation? collectedInformation;
  @JsonKey(name: "consent")
  final dynamic consent;
  @JsonKey(name: "consent_collection")
  final dynamic consentCollection;
  @JsonKey(name: "created")
  final int? created;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "currency_conversion")
  final dynamic currencyConversion;
  @JsonKey(name: "custom_fields")
  final List<dynamic>? customFields;
  @JsonKey(name: "custom_text")
  final CustomText? customText;
  @JsonKey(name: "customer")
  final dynamic customer;
  @JsonKey(name: "customer_account")
  final dynamic customerAccount;
  @JsonKey(name: "customer_creation")
  final String? customerCreation;
  @JsonKey(name: "customer_details")
  final CustomerDetails? customerDetails;
  @JsonKey(name: "customer_email")
  final String? customerEmail;
  @JsonKey(name: "discounts")
  final List<dynamic>? discounts;
  @JsonKey(name: "expires_at")
  final int? expiresAt;
  @JsonKey(name: "invoice")
  final dynamic invoice;
  @JsonKey(name: "invoice_creation")
  final InvoiceCreation? invoiceCreation;
  @JsonKey(name: "livemode")
  final bool? liveMode;
  @JsonKey(name: "locale")
  final dynamic locale;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "mode")
  final String? mode;
  @JsonKey(name: "origin_context")
  final dynamic originContext;
  @JsonKey(name: "payment_intent")
  final dynamic paymentIntent;
  @JsonKey(name: "payment_link")
  final dynamic paymentLink;
  @JsonKey(name: "payment_method_collection")
  final String? paymentMethodCollection;
  @JsonKey(name: "payment_method_configuration_details")
  final PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;
  @JsonKey(name: "payment_method_options")
  final PaymentMethodOptions? paymentMethodOptions;
  @JsonKey(name: "payment_method_types")
  final List<String>? paymentMethodTypes;
  @JsonKey(name: "payment_status")
  final String? paymentStatus;
  @JsonKey(name: "permissions")
  final dynamic permissions;
  @JsonKey(name: "phone_number_collection")
  final PhoneNumberCollection? phoneNumberCollection;
  @JsonKey(name: "recovered_from")
  final dynamic recoveredFrom;
  @JsonKey(name: "saved_payment_method_options")
  final dynamic savedPaymentMethodOptions;
  @JsonKey(name: "setup_intent")
  final dynamic setupIntent;
  @JsonKey(name: "shipping_address_collection")
  final dynamic shippingAddressCollection;
  @JsonKey(name: "shipping_cost")
  final dynamic shippingCost;
  @JsonKey(name: "shipping_details")
  final dynamic shippingDetails;
  @JsonKey(name: "shipping_options")
  final List<dynamic>? shippingOptions;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "submit_type")
  final dynamic submitType;
  @JsonKey(name: "subscription")
  final dynamic subscription;
  @JsonKey(name: "success_url")
  final String? successUrl;
  @JsonKey(name: "total_details")
  final TotalDetails? totalDetails;
  @JsonKey(name: "ui_mode")
  final String? uiMode;
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "wallet_options")
  final dynamic walletOptions;

  SessionDto({
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

  factory SessionDto.fromJson(Map<String, dynamic> json) {
    return _$SessionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SessionDtoToJson(this);
  }

  SessionEntity toEntity() {
    return SessionEntity(
      id: id,
      object: object,
      adaptivePricing: adaptivePricing,
      allowPromotionCodes: allowPromotionCodes,
      amountSubtotal: amountSubtotal,
      amountTotal: amountTotal,
      automaticTax: automaticTax,
      billingAddressCollection: billingAddressCollection,
      brandingSettings: brandingSettings,
      cancelUrl: cancelUrl,
      clientReferenceId: clientReferenceId,
      clientSecret: clientSecret,
      collectedInformation: collectedInformation,
      consent: consent,
      consentCollection: consentCollection,
      created: created,
      currency: currency,
      currencyConversion: currencyConversion,
      customFields: customFields,
      customText: customText,

      customer: customer,
      customerAccount: customerAccount,
      customerCreation: customerCreation,
      customerDetails: customerDetails,
      customerEmail: customerEmail,
      discounts: discounts,
      invoice: invoice,
      invoiceCreation: invoiceCreation,
      liveMode: liveMode,
      locale: locale,
      metadata: metadata,
      mode: mode,
      originContext: originContext,
      paymentIntent: paymentIntent,
      paymentLink: paymentLink,
      paymentMethodCollection: paymentMethodCollection,
      paymentMethodConfigurationDetails: paymentMethodConfigurationDetails,
      paymentMethodOptions: paymentMethodOptions,
      paymentMethodTypes: paymentMethodTypes,
      paymentStatus: paymentStatus,
      permissions: permissions,
      phoneNumberCollection: phoneNumberCollection,
      recoveredFrom: recoveredFrom,
      savedPaymentMethodOptions: savedPaymentMethodOptions,
      setupIntent: setupIntent,
      shippingAddressCollection: shippingAddressCollection,
      shippingCost: shippingCost,
      shippingDetails: shippingDetails,
      shippingOptions: shippingOptions,
      status: status,
      submitType: submitType,
      subscription: subscription,
      successUrl: successUrl,
      totalDetails: totalDetails,
      uiMode: uiMode,
      url: url,
      walletOptions: walletOptions,
      expiresAt: expiresAt,
      afterExpiration: afterExpiration,
    );
  }
}
