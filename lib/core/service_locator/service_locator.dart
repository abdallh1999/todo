import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maids/core/api_service/api_service.dart';
import 'package:maids/core/local_storage/local_storage.dart';
import 'package:maids/core/network_info.dart';
import 'package:maids/features/authentication/data/repos/auth_repo.dart';
import 'package:maids/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:maids/features/pagination/data/data_source/remote_data_source.dart';
import 'package:maids/features/pagination/data/repo/repo.dart';
import 'package:maids/features/pagination/domain/base_repo/base_repo.dart';
import 'package:maids/features/pagination/domain/usecase/use_case.dart';
import 'package:maids/features/pagination/ui/bloc/pagination_bloc.dart';
import 'package:maids/features/todo/data/repos/todo_repo.dart';
import 'package:maids/features/todo/data/repos/todo_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';


final getIt = GetIt.instance;

class AppServiceLocator {
  static Future<void> initAppServiceLocator() async {
    getIt.registerFactory<PaginationBloc>(() => PaginationBloc(getIt()));

    getIt.registerLazySingleton<GetDataUseCase>(
        () => GetDataUseCase(baseRepo: getIt()));

    getIt.registerLazySingleton<BaseRepo>(
        () => Repo(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<RemoteData>(
        () => RemoteDataImpl(getIt.get<ApiService>()));

    // Network information
    getIt.registerLazySingleton(() => InternetConnectionChecker());
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  }
}

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<LocalStorage>(LocalStorage());

  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<TodoRepo>(ToDoRepoImpl(
    getIt.get<ApiService>(),
  ));
}
