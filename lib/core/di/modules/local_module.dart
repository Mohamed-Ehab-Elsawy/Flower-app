import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@module
class LocalModule {
  @singleton
  AssetBundle assetBundle() => rootBundle;
}
