import 'package:json_annotation/json_annotation.dart';

class ContentConverter implements JsonConverter<List<String>?, dynamic> {
  const ContentConverter();

  @override
  List<String>? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return [json];
    if (json is List) return json.map((e) => e.toString()).toList();
    return [];
  }

  @override
  dynamic toJson(List<String>? object) => object;
}
