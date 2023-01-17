part of 'employee_list_bloc.dart';

abstract class EmployeeListState extends Equatable {}

class EmployeeListInitial extends EmployeeListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmployeeListLoadSuccess extends EmployeeListState {
  final List<Employee> items;
  EmployeeListLoadSuccess(this.items);

  @override
  // TODO: implement props
  List<Object?> get props => [items];
}

class EmployeeListLoadFailed extends EmployeeListState {
  final String message;
  EmployeeListLoadFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
