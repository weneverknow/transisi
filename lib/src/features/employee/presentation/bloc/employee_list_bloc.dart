import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transisi/src/core/usecase/usecase.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';
import 'package:transisi/src/features/employee/domain/usecase/fetch_employee_usecase.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc(this.employeeUsecase) : super(EmployeeListInitial()) {
    on<EmployeeListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<EmployeeListLoad>(_load);
    on<EmployeeListInsert>(_insert);
    on<EmployeeListReplace>(_replace);
  }
  final FetchEmployeeUsecase employeeUsecase;
  Future<void> _load(
      EmployeeListLoad event, Emitter<EmployeeListState> emit) async {
    final result = await employeeUsecase.call(NoParam());
    result.fold((l) => emit(EmployeeListLoadFailed(l.message)),
        (r) => emit(EmployeeListLoadSuccess(r)));
  }

  Future<void> _insert(
      EmployeeListInsert event, Emitter<EmployeeListState> emit) async {
    emit(EmployeeListLoadSuccess((state as EmployeeListLoadSuccess)
            .items
            .where((element) => element.id != event.em.id)
            .toList() +
        [event.em]));
  }

  Future<void> _replace(
      EmployeeListReplace event, Emitter<EmployeeListState> emit) async {
    emit(EmployeeListLoadSuccess((state as EmployeeListLoadSuccess)
        .items
        .map((e) => e.id == event.em.id
            ? e.copyWith(
                firstName: event.em.firstName,
                lastName: event.em.lastName,
                job: event.em.job,
                email: event.em.email,
                phone: event.em.phone,
                website: event.em.website,
              )
            : e)
        .toList()));
  }
}
