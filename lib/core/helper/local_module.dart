import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;
}
