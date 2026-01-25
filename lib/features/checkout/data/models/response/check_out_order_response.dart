import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_out_order_response.g.dart';

@JsonSerializable()
class CheckOutOrderResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "session")
  final SessionDto? session;

  CheckOutOrderResponseDto({this.message, this.session});

  factory CheckOutOrderResponseDto.fromJson(Map<String, dynamic> json) {
    return _$CheckOutOrderResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CheckOutOrderResponseDtoToJson(this);
  }
}

@JsonSerializable()
class AdaptivePricing {
  @JsonKey(name: "enabled")
  final bool? enabled;

  AdaptivePricing({this.enabled});

  factory AdaptivePricing.fromJson(Map<String, dynamic> json) {
    return _$AdaptivePricingFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AdaptivePricingToJson(this);
  }
}

@JsonSerializable()
class AutomaticTax {
  @JsonKey(name: "enabled")
  final bool? enabled;
  @JsonKey(name: "liability")
  final dynamic liability;
  @JsonKey(name: "provider")
  final dynamic provider;
  @JsonKey(name: "status")
  final dynamic status;

  AutomaticTax({this.enabled, this.liability, this.provider, this.status});

  factory AutomaticTax.fromJson(Map<String, dynamic> json) {
    return _$AutomaticTaxFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AutomaticTaxToJson(this);
  }
}

@JsonSerializable()
class BrandingSettings {
  @JsonKey(name: "background_color")
  final String? backgroundColor;
  @JsonKey(name: "border_style")
  final String? borderStyle;
  @JsonKey(name: "button_color")
  final String? buttonColor;
  @JsonKey(name: "display_name")
  final String? displayName;
  @JsonKey(name: "font_family")
  final String? fontFamily;
  @JsonKey(name: "icon")
  final BrandingIcon? icon;
  @JsonKey(name: "logo")
  final Logo? logo;

  BrandingSettings({
    this.backgroundColor,
    this.borderStyle,
    this.buttonColor,
    this.displayName,
    this.fontFamily,
    this.icon,
    this.logo,
  });

  factory BrandingSettings.fromJson(Map<String, dynamic> json) {
    return _$BrandingSettingsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BrandingSettingsToJson(this);
  }
}

@JsonSerializable()
class BrandingIcon {
  @JsonKey(name: "file")
  final String? file;
  @JsonKey(name: "type")
  final String? type;

  BrandingIcon({this.file, this.type});

  factory BrandingIcon.fromJson(Map<String, dynamic> json) {
    return _$BrandingIconFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BrandingIconToJson(this);
  }
}

@JsonSerializable()
class Logo {
  @JsonKey(name: "file")
  final String? file;
  @JsonKey(name: "type")
  final String? type;

  Logo({this.file, this.type});

  factory Logo.fromJson(Map<String, dynamic> json) {
    return _$LogoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LogoToJson(this);
  }
}

@JsonSerializable()
class CollectedInformation {
  @JsonKey(name: "business_name")
  final dynamic businessName;
  @JsonKey(name: "individual_name")
  final dynamic individualName;
  @JsonKey(name: "shipping_details")
  final dynamic shippingDetails;

  CollectedInformation({
    this.businessName,
    this.individualName,
    this.shippingDetails,
  });

  factory CollectedInformation.fromJson(Map<String, dynamic> json) {
    return _$CollectedInformationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CollectedInformationToJson(this);
  }
}

@JsonSerializable()
class CustomText {
  @JsonKey(name: "after_submit")
  final dynamic afterSubmit;
  @JsonKey(name: "shipping_address")
  final dynamic shippingAddress;
  @JsonKey(name: "submit")
  final dynamic submit;
  @JsonKey(name: "terms_of_service_acceptance")
  final dynamic termsOfServiceAcceptance;

  CustomText({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  factory CustomText.fromJson(Map<String, dynamic> json) {
    return _$CustomTextFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CustomTextToJson(this);
  }
}

@JsonSerializable()
class CustomerDetails {
  @JsonKey(name: "address")
  final dynamic address;
  @JsonKey(name: "business_name")
  final dynamic businessName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "individual_name")
  final dynamic individualName;
  @JsonKey(name: "name")
  final dynamic name;
  @JsonKey(name: "phone")
  final dynamic phone;
  @JsonKey(name: "tax_exempt")
  final String? taxExempt;
  @JsonKey(name: "tax_ids")
  final dynamic taxIds;

  CustomerDetails({
    this.address,
    this.businessName,
    this.email,
    this.individualName,
    this.name,
    this.phone,
    this.taxExempt,
    this.taxIds,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return _$CustomerDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CustomerDetailsToJson(this);
  }
}

@JsonSerializable()
class InvoiceCreation {
  @JsonKey(name: "enabled")
  final bool? enabled;
  @JsonKey(name: "invoice_data")
  final InvoiceData? invoiceData;

  InvoiceCreation({this.enabled, this.invoiceData});

  factory InvoiceCreation.fromJson(Map<String, dynamic> json) {
    return _$InvoiceCreationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InvoiceCreationToJson(this);
  }
}

@JsonSerializable()
class InvoiceData {
  @JsonKey(name: "account_tax_ids")
  final dynamic accountTaxIds;
  @JsonKey(name: "custom_fields")
  final dynamic customFields;
  @JsonKey(name: "description")
  final dynamic description;
  @JsonKey(name: "footer")
  final dynamic footer;
  @JsonKey(name: "issuer")
  final dynamic issuer;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "rendering_options")
  final dynamic renderingOptions;

  InvoiceData({
    this.accountTaxIds,
    this.customFields,
    this.description,
    this.footer,
    this.issuer,
    this.metadata,
    this.renderingOptions,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return _$InvoiceDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InvoiceDataToJson(this);
  }
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "street")
  final String? street;

  Metadata({this.city, this.lat, this.long, this.phone, this.street});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataToJson(this);
  }
}

@JsonSerializable()
class PaymentMethodConfigurationDetails {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "parent")
  final dynamic parent;

  PaymentMethodConfigurationDetails({this.id, this.parent});

  factory PaymentMethodConfigurationDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    return _$PaymentMethodConfigurationDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaymentMethodConfigurationDetailsToJson(this);
  }
}

@JsonSerializable()
class PaymentMethodOptions {
  @JsonKey(name: "card")
  final Card? card;

  PaymentMethodOptions({this.card});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return _$PaymentMethodOptionsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaymentMethodOptionsToJson(this);
  }
}

@JsonSerializable()
class Card {
  @JsonKey(name: "request_three_d_secure")
  final String? requestThreeDSecure;

  Card({this.requestThreeDSecure});

  factory Card.fromJson(Map<String, dynamic> json) {
    return _$CardFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CardToJson(this);
  }
}

@JsonSerializable()
class PhoneNumberCollection {
  @JsonKey(name: "enabled")
  final bool? enabled;

  PhoneNumberCollection({this.enabled});

  factory PhoneNumberCollection.fromJson(Map<String, dynamic> json) {
    return _$PhoneNumberCollectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PhoneNumberCollectionToJson(this);
  }
}

@JsonSerializable()
class TotalDetails {
  @JsonKey(name: "amount_discount")
  final int? amountDiscount;
  @JsonKey(name: "amount_shipping")
  final int? amountShipping;
  @JsonKey(name: "amount_tax")
  final int? amountTax;

  TotalDetails({this.amountDiscount, this.amountShipping, this.amountTax});

  factory TotalDetails.fromJson(Map<String, dynamic> json) {
    return _$TotalDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TotalDetailsToJson(this);
  }
}
