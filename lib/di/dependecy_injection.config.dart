// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:universo_marvel/app/api_source.dart' as _i5;
import 'package:universo_marvel/detail_reference/bloc/detail_reference_bloc.dart'
    as _i12;
import 'package:universo_marvel/detail_reference/repository/detail_reference_api.dart'
    as _i7;
import 'package:universo_marvel/detail_reference/repository/detail_reference_repository.dart'
    as _i6;
import 'package:universo_marvel/detail_reference/repository/detail_reference_use_case.dart'
    as _i8;
import 'package:universo_marvel/home/bloc/home_bloc.dart' as _i13;
import 'package:universo_marvel/home/repository/home_api.dart' as _i10;
import 'package:universo_marvel/home/repository/home_repository.dart' as _i9;
import 'package:universo_marvel/home/repository/home_use_case.dart' as _i11;
import 'package:universo_marvel/utils/connectivity/connectivity_adapter.dart'
    as _i4;

import 'module.dart' as _i14;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dIModule = _$DIModule();
  gh.factory<_i3.Client>(() => dIModule.client);
  gh.factory<_i4.Connectivity>(() => _i4.ConnectivityAdapter());
  gh.factory<String>(
    () => dIModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.singleton<_i5.ApiSource>(_i5.ApiSource(
    gh<String>(instanceName: 'baseUrl'),
    gh<_i3.Client>(),
    gh<_i4.Connectivity>(),
  ));
  gh.factory<_i6.DetailReferenceRepository>(
      () => _i7.DetailReferenceRepositoryImpl(gh<_i5.ApiSource>()));
  gh.factory<_i8.DetailReferenceUseCase>(() =>
      _i8.DetailReferenceUseCaseImpl(gh<_i6.DetailReferenceRepository>()));
  gh.factory<_i9.HomeRepository>(
      () => _i10.HomeRepositoryImpl(gh<_i5.ApiSource>()));
  gh.factory<_i11.HomeUseCase>(
      () => _i11.HomeUseCaseImpl(gh<_i9.HomeRepository>()));
  gh.factory<_i12.DetailReferenceBloc>(
      () => _i12.DetailReferenceBloc(gh<_i8.DetailReferenceUseCase>()));
  gh.factory<_i13.HomeBloc>(() => _i13.HomeBloc(gh<_i11.HomeUseCase>()));
  return getIt;
}

class _$DIModule extends _i14.DIModule {}
