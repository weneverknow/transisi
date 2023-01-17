import 'package:transisi/src/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:transisi/src/core/usecase/usecase.dart';
import 'package:transisi/src/features/authentication/domain/entities/authentication.dart';
import 'package:transisi/src/features/authentication/domain/repository/authentication_repository.dart';

class LoginUseCase implements UseCase<Authentication, LoginParam> {
  final AuthenticationRepository repository;
  LoginUseCase(this.repository);
  @override
  Future<Either<Failure, Authentication>> call(LoginParam param) async {
    return await repository.login(email: param.email, password: param.password);
  }
}

class LoginParam {
  final String email;
  final String password;

  LoginParam({
    required this.email,
    required this.password,
  });
}
