import 'package:flower_app/core/app/domain/repositories/app_sections_repo.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserDataUseCase {
  final AppSectionsRepo _appSectionsRepo;

  GetUserDataUseCase(this._appSectionsRepo);

  Future<Result<UserEntity>> call() => _appSectionsRepo.getUserData();
}
