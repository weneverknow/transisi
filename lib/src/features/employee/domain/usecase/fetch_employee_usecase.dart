import 'package:transisi/src/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:transisi/src/core/usecase/usecase.dart';
import 'package:transisi/src/features/employee/domain/repository/employee_repository.dart';

import '../entities/employee.dart';

class FetchEmployeeUsecase implements UseCase<List<Employee>, NoParam> {
  final EmployeeRepository repository;
  FetchEmployeeUsecase(this.repository);
  @override
  Future<Either<Failure, List<Employee>>> call(NoParam param) async {
    return await repository.fetch();
  }
}
