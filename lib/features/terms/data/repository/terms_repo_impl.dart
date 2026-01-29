import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/terms/data/data_source/terms_local_data_source.dart';
import 'package:flower_app/features/terms/data/mapper/terms_mapper.dart';
import 'package:flower_app/features/terms/data/models/terms_response_dto.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';
import 'package:flower_app/features/terms/domain/repository/terms_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TermsRepo)
class TermsRepoImpl implements TermsRepo {
  final TermsLocalDataSource termsLocalDataSource;

  TermsRepoImpl(this.termsLocalDataSource);

  @override
  Future<Result<List<TermsEntity>>> getTermsAndConditions() async {
    final dto = await termsLocalDataSource.getTerms();
    if (dto is Success<TermsResponseDTO>) {
      final List<TermsEntity> entities = dto.data.toEntity();
      return Success(entities);
    } else {
      return Failure((dto as Failure).errorMessage);
    }
  }
}
