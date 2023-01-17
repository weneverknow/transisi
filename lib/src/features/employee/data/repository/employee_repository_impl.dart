import 'package:transisi/src/core/exceptions/exceptions.dart';
import 'package:transisi/src/features/employee/data/datasource/employee_datasource.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';

import 'package:transisi/src/core/failure/failure.dart';

import 'package:dartz/dartz.dart';

import '/src/features/employee/domain/repository/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeDatasource datasource;
  EmployeeRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, List<Employee>>> fetch() async {
    try {
      final response = await datasource.fetch();
      return right(response.map((e) => e.toEntities()).toList());
    } on DataNotFoundException catch (e) {
      return left(FetchFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Employee>> create({
    String? firstName,
    String? lastName,
    String? job,
    String? email,
    String? phone,
    String? website,
  }) async {
    try {
      final result = await datasource.create(
        firstName: firstName,
        lastName: lastName,
        job: job,
        email: email,
        phone: phone,
        website: website,
      );
      return right(result.toEntities());
    } on HttpErrorException catch (e) {
      return left(FetchFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Employee>> update(Employee employee) async {
    try {
      final result = await datasource.update(
        employee.id!,
        employee.toJson(),
      );
      return right(result.toEntities());
    } on HttpErrorException catch (e) {
      return left(FetchFailure(e.message));
    }
  }
}
