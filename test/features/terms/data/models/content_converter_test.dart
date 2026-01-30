import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/terms/data/models/content_converter.dart';

void main() {
  const converter = ContentConverter();

  group('ContentConverter Tests', () {
    test('should return null when input is null', () {
      expect(converter.fromJson(null), isNull);
    });

    test('should wrap a single String into a List', () {
      const input = "Single string term";
      final result = converter.fromJson(input);

      expect(result, equals(["Single string term"]));
    });

    test('should convert a List of dynamic into a List of Strings', () {
      const input = ["Term 1", 123, true]; // Mixed types
      final result = converter.fromJson(input);

      expect(result, equals(["Term 1", "123", "true"]));
    });

    test('should return an empty list for unexpected types (e.g., Map)', () {
      final input = {"key": "value"};
      final result = converter.fromJson(input);

      expect(result, isEmpty);
    });
  });
}
