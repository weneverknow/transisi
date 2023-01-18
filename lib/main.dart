import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transisi/src/core/cubit/loading_cubit.dart';
import 'package:transisi/src/features/authentication/domain/entities/authentication.dart';
import 'package:transisi/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:transisi/src/features/authentication/presentation/cubit/login_storage_cubit.dart';
import 'package:transisi/src/routes.dart';
import 'src/features/authentication/domain/usecase/login_from_storage_use_case.dart';
import 'src/features/authentication/domain/usecase/login_use_case.dart';
import 'src/features/employee/domain/usecase/fetch_employee_usecase.dart';
import 'src/features/employee/presentation/bloc/employee_list_bloc.dart';
import 'src/service_locator.dart' as serviceLocator;

void main() {
  serviceLocator.setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AuthenticationBloc(
                loginUseCase: serviceLocator.sl<LoginUseCase>())),
        BlocProvider(create: (_) => LoadingCubit()),
        BlocProvider(
            create: (_) =>
                EmployeeListBloc(serviceLocator.sl<FetchEmployeeUsecase>())
                  ..add(EmployeeListLoad())),
        BlocProvider(
            create: (_) =>
                LoginStorageCubit(serviceLocator.sl<LoginFromStorageUseCase>())
                  ..checkLogin()),
      ],
      child: BlocBuilder<LoginStorageCubit, Authentication?>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Transisi App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                colorScheme: const ColorScheme.light(
                    secondary: Color.fromARGB(255, 123, 183, 232),
                    primary: Color.fromARGB(255, 16, 95, 159))),
            routerConfig: routes(authentication: state),
          );
        },
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print("bloc ${bloc.runtimeType} $change");
    super.onChange(bloc, change);
  }
}
