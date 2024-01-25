part of 'employee_list_bloc.dart';

abstract class EmployeeListState extends Equatable {
  const EmployeeListState();
}

class EmployeeListInitial extends EmployeeListState {
  @override
  List<Object> get props => [];
}

class EmployeeListLoading extends EmployeeListState {
  @override
  List<Object> get props => [];
}

class EmployeeListSuccess extends EmployeeListState {
  @override
  List<Object> get props => [];
}

class EmployeeListFailed extends EmployeeListState {
  const EmployeeListFailed();

  @override
  List<Object> get props => [];
}
