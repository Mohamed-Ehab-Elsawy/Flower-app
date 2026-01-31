import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalModule {
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;
}
