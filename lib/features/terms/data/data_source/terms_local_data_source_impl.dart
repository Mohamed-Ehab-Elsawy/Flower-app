import 'dart:convert';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/assets_manager.dart';
import 'package:flower_app/features/terms/data/data_source/terms_local_data_source.dart';
import 'package:flower_app/features/terms/data/models/terms_response_dto.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TermsLocalDataSource)
class TermsLocalDataSourceImpl implements TermsLocalDataSource {
  final AssetBundle assetBundle;

  TermsLocalDataSourceImpl({required this.assetBundle});

  @override
  Future<Result<TermsResponseDTO>> getTerms() async {
    try {
      final String response = await assetBundle.loadString(
        AssetsManager.termsJsonPath,
      );
      final data = await json.decode(response);
      var terms = TermsResponseDTO.fromJson(data);
      return Success(terms);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
