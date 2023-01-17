import 'package:transisi/src/core/exceptions/exceptions.dart';
import 'package:transisi/src/features/authentication/data/datasource/authentication_datasource.dart';
import 'package:transisi/src/features/authentication/domain/entities/authentication.dart';

import 'package:transisi/src/core/failure/failure.dart';

import 'package:dartz/dartz.dart';

import '/src/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDatasource datasource;
  AuthenticationRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, Authentication>> login(
      {required String email, required String password}) async {
    try {
      final response = await datasource.login(email: email, password: password);
      return right(response);
    } on AuthenticationErrorException catch (e) {
      return left(FetchFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Authentication>> loginFromStorage() async {
    try {
      final result = await datasource.loginFromStorage();
      if (result == null) {
        return left(FetchFailure("User not yet logged in"));
      }
      return right(Authentication(
        token: result,
      ));
    } catch (e) {
      return left(FetchFailure("User not yet logged in"));
    }
  }
}
