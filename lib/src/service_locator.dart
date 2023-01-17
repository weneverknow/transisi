import 'package:get_it/get_it.dart';
import 'package:transisi/src/core/connection/remote_service.dart';
import 'package:transisi/src/features/authentication/data/datasource/authentication_datasource.dart';
import 'package:transisi/src/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:transisi/src/features/authentication/domain/repository/authentication_repository.dart';
import 'package:transisi/src/features/authentication/domain/usecase/login_from_storage_use_case.dart';
import 'package:transisi/src/features/authentication/domain/usecase/login_use_case.dart';
import 'package:transisi/src/features/employee/data/datasource/employee_datasource.dart';
import 'package:transisi/src/features/employee/data/repository/employee_repository_impl.dart';
import 'package:transisi/src/features/employee/domain/repository/employee_repository.dart';
import 'package:transisi/src/features/employee/domain/usecase/create_employee_usecase.dart';
import 'package:transisi/src/features/employee/domain/usecase/fetch_employee_usecase.dart';
import 'package:transisi/src/features/employee/domain/usecase/update_employee_usecase.dart';

final GetIt sl = GetIt.instance;

setupServiceLocator() {
  /**
   * register connection service
   */
  sl.registerLazySingleton<RemoteService>(() => RemoteServiceImpl());
  /**
   * register datasource
   */
  sl.registerLazySingleton<AuthenticationDatasource>(
      () => AuthenticationDatasourceImpl(sl<RemoteService>()));
  sl.registerLazySingleton<EmployeeDatasource>(
      () => EmployeeDatasourceImpl(sl<RemoteService>()));

  /**
       * register repository
       */
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl<AuthenticationDatasource>()));
  sl.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(sl<EmployeeDatasource>()));

  /**
       * register usecase
       */
  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton<LoginFromStorageUseCase>(
      () => LoginFromStorageUseCase(sl<AuthenticationRepository>()));

  sl.registerLazySingleton<FetchEmployeeUsecase>(
      () => FetchEmployeeUsecase(sl<EmployeeRepository>()));
  sl.registerLazySingleton<CreateEmployeeUsecase>(
      () => CreateEmployeeUsecase(sl<EmployeeRepository>()));
  sl.registerLazySingleton<UpdateEmployeeUsecase>(
      () => UpdateEmployeeUsecase(sl<EmployeeRepository>()));
}
