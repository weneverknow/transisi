import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transisi/src/features/employee/domain/entities/employee_validation.dart';

class EmployeeValidationCubit extends Cubit<EmployeeValidation?> {
  EmployeeValidationCubit() : super(null);

  validate({
    String? firstName,
    String? lastName,
    String? email,
    String? website,
  }) {
    emit(EmployeeValidation(
      firstName: firstName,
      lastName: lastName,
      email: email,
      website: website,
    ));
  }
}
