import 'package:dartz/dartz.dart';
import 'package:transisi/src/core/failure/failure.dart';
import 'package:transisi/src/features/authentication/domain/entities/authentication.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Authentication>> login(
      {required String email, required String password});
  Future<Either<Failure, Authentication>> loginFromStorage();
}
