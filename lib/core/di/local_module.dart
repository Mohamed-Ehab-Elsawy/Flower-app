import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/terms/data/models/terms_response_dto.dart';

abstract interface class TermsLocalDataSource {
  Future<Result<TermsResponseDTO>> getTerms();
}
