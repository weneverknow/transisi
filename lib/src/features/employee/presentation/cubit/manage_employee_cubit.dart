import 'package:bloc/bloc.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';
import 'package:transisi/src/features/employee/domain/usecase/create_employee_usecase.dart';
import 'package:transisi/src/features/employee/domain/usecase/update_employee_usecase.dart';

class ManageEmployeeCubit extends Cubit<Employee?> {
  ManageEmployeeCubit(
    this.employeeUsecase,
    this.updateEmployeeUsecase,
  ) : super(null);

  final CreateEmployeeUsecase employeeUsecase;
  final UpdateEmployeeUsecase updateEmployeeUsecase;

  update(Employee employee) async {
    final result = await updateEmployeeUsecase.call(employee);
    result.fold((l) => emit(null), (r) => emit(r));
  }

  create(
      {String? firstName,
      String? lastName,
      String? job,
      String? email,
      String? phone,
      String? website}) async {
    final result = await employeeUsecase.call(CreateEmployeeParam(
      firstName: firstName,
      lastName: lastName,
      job: job,
      email: email,
      phone: phone,
      website: website,
    ));

    result.fold((l) => emit(null), (r) => emit(r));
  }
}
