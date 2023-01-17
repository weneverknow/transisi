import 'package:transisi/src/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:transisi/src/core/usecase/usecase.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';
import 'package:transisi/src/features/employee/domain/repository/employee_repository.dart';

class CreateEmployeeUsecase implements UseCase<Employee, CreateEmployeeParam> {
  final EmployeeRepository repository;
  CreateEmployeeUsecase(this.repository);
  @override
  Future<Either<Failure, Employee>> call(CreateEmployeeParam param) async {
    return await repository.create(
      firstName: param.firstName,
      lastName: param.lastName,
      job: param.job,
      email: param.email,
      phone: param.phone,
      website: param.website,
    );
  }
}

class CreateEmployeeParam {
  final String? firstName;
  final String? lastName;
  final String? job;
  final String? email;
  final String? phone;
  final String? website;

  CreateEmployeeParam({
    this.firstName,
    this.lastName,
    this.job,
    this.email,
    this.phone,
    this.website,
  });
}
