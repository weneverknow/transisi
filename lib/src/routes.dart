import 'package:go_router/go_router.dart';
import 'package:transisi/src/features/authentication/presentation/authentication_screen.dart';
import 'package:transisi/src/features/employee/presentation/employee_detail_screen.dart';
import 'package:transisi/src/features/employee/presentation/employee_form_screen.dart';
import 'package:transisi/src/features/employee/presentation/employee_screen.dart';

import 'features/authentication/domain/entities/authentication.dart';

GoRouter routes({
  Authentication? authentication,
}) {
  return GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => const EmployeeScreen(),
          routes: [
            GoRoute(
                path: 'detail/:id',
                builder: (context, state) => EmployeeDetailScreen(
                    id: int.tryParse(state.params['id'] ?? "")!)),
            GoRoute(
                path: 'create',
                builder: (context, state) => EmployeeFormScreen()),
            GoRoute(
                path: 'edit/:id',
                builder: (context, state) => EmployeeFormScreen(
                      id: int.tryParse(state.params['id'] ?? ""),
                    ))
          ]),
      GoRoute(
        path: '/login',
        redirect: (context, state) async =>
            authentication == null ? "/login" : "/",
        builder: (context, state) => AuthenticationScreen(),
      )
    ],

    initialLocation: '/login',
    debugLogDiagnostics: true,
    routerNeglect: true,
    //context.watch<LoginStorageCubit>().state == null ? "/login" : "/",
  );
}

// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const EmployeeScreen(),
//     ),
//     GoRoute(
//       path: '/login',
//       builder: (context, state) => AuthenticationScreen(),
//     )
//   ],
//   redirect: (context, state) async =>
//       context.watch<LoginStorageCubit>().state == null ? "/login" : "/",
//   initialLocation: '/login',
//   debugLogDiagnostics: true,
//   routerNeglect: true,
//   //context.watch<LoginStorageCubit>().state == null ? "/login" : "/",
// );
