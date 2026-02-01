import 'package:json_annotation/json_annotation.dart';

part 'about_us_dto.g.dart';

@JsonSerializable()
class AboutUsDto {
  @JsonKey(name: "about_app")
  final List<AboutApp>? aboutApp;

  AboutUsDto({this.aboutApp});

  factory AboutUsDto.fromJson(Map<String, dynamic> json) {
    return _$AboutUsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AboutUsDtoToJson(this);
  }
}

@JsonSerializable()
class AboutApp {
  @JsonKey(name: "section")
  final String? section;

  @JsonKey(name: "title")
  final Content? title;

  @JsonKey(name: "content")
  final Content? content;

  @JsonKey(name: "style")
  final Style? style;

  AboutApp({this.section, this.title, this.content, this.style});

  factory AboutApp.fromJson(Map<String, dynamic> json) {
    return _$AboutAppFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AboutAppToJson(this);
  }
}

@JsonSerializable()
class Content {
  @JsonKey(name: "en")
  final dynamic en;
  @JsonKey(name: "ar")
  final dynamic ar;

  Content({this.en, this.ar});

  factory Content.fromJson(Map<String, dynamic> json) {
    return _$ContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ContentToJson(this);
  }
}

@JsonSerializable()
class Style {
  @JsonKey(name: "fontSize")
  final int? fontSize;
  @JsonKey(name: "fontWeight")
  final String? fontWeight;
  @JsonKey(name: "color")
  final String? color;
  @JsonKey(name: "textAlign")
  final TextAlign? textAlign;
  @JsonKey(name: "backgroundColor")
  final String? backgroundColor;

  Style({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });

  factory Style.fromJson(Map<String, dynamic> json) {
    return _$StyleFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StyleToJson(this);
  }
}

@JsonSerializable()
class TextAlign {
  @JsonKey(name: "en")
  final String? en;
  @JsonKey(name: "ar")
  final String? ar;

  TextAlign({this.en, this.ar});

  factory TextAlign.fromJson(Map<String, dynamic> json) {
    return _$TextAlignFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TextAlignToJson(this);
  }
}
