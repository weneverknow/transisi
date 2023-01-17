import 'package:dartz/dartz.dart';
import 'package:transisi/src/core/failure/failure.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> fetch();
  Future<Either<Failure, Employee>> create(
      {String? firstName,
      String? lastName,
      String? job,
      String? email,
      String? phone,
      String? website});

  Future<Either<Failure, Employee>> update(Employee employee);
}
