import 'dart:convert';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/data/data_source/profile_local_data_source_impl.dart';
import 'package:flower_app/features/profile/data/models/about_us_dto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProfileLocalDataSourceImpl dataSource;
  const String assetPath = 'assets/json/about_us.json';

  setUp(() {
    dataSource = ProfileLocalDataSourceImpl();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', null);
    rootBundle.evict(assetPath);
  });

  void mockAssetResponse(dynamic data, {bool shouldThrow = false}) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
          final Uint8List encodedMessage = message!.buffer.asUint8List();
          final String requestedPath = utf8.decode(encodedMessage);

          if (requestedPath.contains(assetPath)) {
            if (shouldThrow) throw Exception();
            final String content = data is String ? data : json.encode(data);
            return utf8.encode(content).buffer.asByteData();
          }
          return null;
        });
  }

  group('ProfileLocalDataSource - getAboutUs Tests', () {
    test('1. Success Case', () async {
      final mockJson = {
        "about_app": [
          {
            "section": "About",
            "content": {"en": "Us", "ar": "نحن"},
            "style": {"fontSize": 14},
          },
        ],
      };
      mockAssetResponse(mockJson);

      final result = await dataSource.getAboutUs();

      expect(result, isA<Success<AboutUsDto>>());
      final successData = (result as Success<AboutUsDto>).data;
      expect(successData.aboutApp, isNotNull);
      expect(successData.aboutApp!.first.section, "About");
    });

    test('2. Parsing Failure', () async {
      mockAssetResponse("invalid");

      final result = await dataSource.getAboutUs();

      expect(result, isA<Failure<AboutUsDto>>());
    });

    test('3. Asset Loading Failure', () async {
      mockAssetResponse(null, shouldThrow: true);

      final result = await dataSource.getAboutUs();

      expect(result, isA<Failure<AboutUsDto>>());
    });
  });
}
