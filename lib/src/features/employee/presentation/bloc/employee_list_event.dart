part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent extends Equatable {}

class EmployeeListLoad extends EmployeeListEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmployeeListInsert extends EmployeeListEvent {
  final Employee em;
  EmployeeListInsert(this.em);

  @override
  // TODO: implement props
  List<Object?> get props => [em];
}

class EmployeeListReplace extends EmployeeListEvent {
  final Employee em;
  EmployeeListReplace(this.em);

  @override
  // TODO: implement props
  List<Object?> get props => [em];
}
