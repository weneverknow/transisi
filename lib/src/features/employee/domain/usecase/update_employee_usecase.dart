import 'package:transisi/src/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:transisi/src/core/usecase/usecase.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';
import 'package:transisi/src/features/employee/domain/repository/employee_repository.dart';

class UpdateEmployeeUsecase implements UseCase<Employee, Employee> {
  final EmployeeRepository repository;
  UpdateEmployeeUsecase(this.repository);
  @override
  Future<Either<Failure, Employee>> call(Employee employee) async {
    return await repository.update(employee);
  }
}
