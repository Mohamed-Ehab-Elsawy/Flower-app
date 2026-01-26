import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';

abstract interface class TermsRepo {
  Future<Result<List<TermsEntity>>> getTermsAndConditions();
}
