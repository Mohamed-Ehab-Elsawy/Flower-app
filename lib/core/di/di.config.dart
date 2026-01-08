// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker_dio_logger/talker_dio_logger.dart' as _i52;

import '../../features/auth/data/datasources/auth_ds.dart' as _i586;
import '../../features/auth/data/datasources/auth_ds_impl.dart' as _i775;
import '../../features/auth/data/repositories/auth_repo_impl.dart' as _i662;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/use_cases/forget_password/reset_password_use_case.dart'
    as _i437;
import '../../features/auth/domain/use_cases/forget_password/send_reset_password_code_use_case.dart'
    as _i876;
import '../../features/auth/domain/use_cases/forget_password/verify_reset_password_code_use_case.dart'
    as _i1073;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/signup_use_case.dart' as _i571;
import '../../features/auth/presentation/cubit/forget_password/forget_password_cubit.dart'
    as _i817;
import '../../features/auth/presentation/cubit/login_view_model/login_view_model.dart'
    as _i869;
import '../../features/auth/presentation/cubit/signup_viewmodel.dart' as _i68;
import '../../features/categories/data/datasources/category_data_source.dart'
    as _i842;
import '../../features/categories/data/datasources/category_data_source_impl.dart'
    as _i236;
import '../../features/categories/data/repo/category_repo_impl.dart' as _i782;
import '../../features/categories/domain/repo/category_repo.dart' as _i51;
import '../../features/categories/domain/usecases/get_categories_use_case.dart'
    as _i308;
import '../../features/categories/presentation/view/manager/categories_view_cubit.dart'
    as _i553;
import '../../features/home/data/datasources/home_data_source.dart' as _i426;
import '../../features/home/data/datasources/home_data_source_impl.dart'
    as _i375;
import '../../features/home/data/repo/home_repo_impl.dart' as _i1024;
import '../../features/home/domain/repo/home_repo.dart' as _i280;
import '../../features/home/domain/usecases/fetch_home_data_usecase.dart'
    as _i798;
import '../../features/home/domain/usecases/get_best_seller_use_case.dart'
    as _i92;
import '../../features/home/domain/usecases/get_products.dart' as _i491;
import '../../features/home/presentation/cubit/best_seller_view_model.dart'
    as _i645;
import '../../features/home/presentation/occasions/occasions_cubit.dart'
    as _i240;
import '../../features/home/presentation/view_model/home_view_model.dart'
    as _i77;
import '../../features/orders/data/datasources/order_data_source.dart' as _i812;
import '../../features/orders/data/datasources/order_data_source_impl.dart'
    as _i589;
import '../../features/orders/data/repositories/order_repo_impl.dart' as _i977;
import '../../features/orders/domain/repositories/order_repo.dart' as _i93;
import '../../features/orders/presentation/view_model/order_viewmodel.dart'
    as _i20;
import '../api/api_client.dart' as _i277;
import '../api/api_module.dart' as _i0;
import '../app/presentation/view_model/app_section_view_model.dart' as _i752;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    gh.factory<_i752.AppSectionViewModel>(() => _i752.AppSectionViewModel());
    gh.lazySingleton<_i361.BaseOptions>(() => apiModule.providerOption());
    gh.lazySingleton<_i52.TalkerDioLogger>(() => apiModule.provideLogger());
    await gh.lazySingletonAsync<_i361.Dio>(
      () => apiModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i52.TalkerDioLogger>(),
      ),
      preResolve: true,
    );
    gh.lazySingleton<_i277.ApiClient>(
      () => apiModule.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i812.OrderDataSource>(
      () => _i589.OrderDataSourceImplImpl(gh<_i277.ApiClient>()),
    );
    gh.factory<_i586.AuthDataSource>(
      () => _i775.AuthDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i842.CategoryDataSource>(
      () => _i236.CategoryDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i426.HomeDataSource>(
      () => _i375.HomeDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i93.OrderRepo>(
      () => _i977.OrderRepoImpl(gh<_i812.OrderDataSource>()),
    );
    gh.lazySingleton<_i280.HomeRepo>(
      () => _i1024.HomeRepoImpl(gh<_i426.HomeDataSource>()),
    );
    gh.factory<_i491.GetProductsUseCase>(
      () => _i491.GetProductsUseCase(gh<_i280.HomeRepo>()),
    );
    gh.lazySingleton<_i723.AuthRepo>(
      () => _i662.AuthRepoImpl(gh<_i586.AuthDataSource>()),
    );
    gh.factory<_i240.OccasionsCubit>(
      () => _i240.OccasionsCubit(gh<_i491.GetProductsUseCase>()),
    );
    gh.lazySingleton<_i20.OrderViewModel>(
      () => _i20.OrderViewModel(gh<_i93.OrderRepo>()),
    );
    gh.lazySingleton<_i51.CategoryRepo>(
      () => _i782.CategoryRepoImpl(gh<_i842.CategoryDataSource>()),
    );
    gh.factory<_i437.ResetPasswordUseCase>(
      () => _i437.ResetPasswordUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i876.SendResetPasswordCodeUseCase>(
      () => _i876.SendResetPasswordCodeUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i1073.VerifyResetPasswordCodeUseCase>(
      () => _i1073.VerifyResetPasswordCodeUseCase(gh<_i723.AuthRepo>()),
    );
    gh.lazySingleton<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i308.GetCategoriesUseCase>(
      () => _i308.GetCategoriesUseCase(gh<_i51.CategoryRepo>()),
    );
    gh.lazySingleton<_i798.FetchHomeDataUsecase>(
      () => _i798.FetchHomeDataUsecase(gh<_i280.HomeRepo>()),
    );
    gh.factory<_i92.GetBestSellerUseCase>(
      () => _i92.GetBestSellerUseCase(gh<_i280.HomeRepo>()),
    );
    gh.factory<_i571.SignUpUseCase>(
      () => _i571.SignUpUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i817.ForgetPasswordCubit>(
      () => _i817.ForgetPasswordCubit(
        gh<_i876.SendResetPasswordCodeUseCase>(),
        gh<_i1073.VerifyResetPasswordCodeUseCase>(),
        gh<_i437.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i68.SignUpViewModel>(
      () => _i68.SignUpViewModel(gh<_i571.SignUpUseCase>()),
    );
    gh.factory<_i553.CategoriesViewCubit>(
      () => _i553.CategoriesViewCubit(
        gh<_i308.GetCategoriesUseCase>(),
        gh<_i491.GetProductsUseCase>(),
      ),
    );
    gh.factory<_i869.LoginViewModel>(
      () => _i869.LoginViewModel(gh<_i1038.LoginUseCase>()),
    );
    gh.factory<_i77.HomeViewModel>(
      () => _i77.HomeViewModel(gh<_i798.FetchHomeDataUsecase>()),
    );
    gh.factory<_i645.BestSellerViewModel>(
      () => _i645.BestSellerViewModel(gh<_i92.GetBestSellerUseCase>()),
    );
    return this;
  }
}

class _$ApiModule extends _i0.ApiModule {}
