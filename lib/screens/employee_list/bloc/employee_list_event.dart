part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent extends Equatable {
  const EmployeeListEvent();
}

class GetEmployeesEvent extends EmployeeListEvent {
  const GetEmployeesEvent();

  @override
  List<Object?> get props => [];
}

class AddEmployeeEvent extends EmployeeListEvent {
  final EmployeeDetails employeeDetails;

  const AddEmployeeEvent({required this.employeeDetails});

  @override
  List<Object?> get props => [employeeDetails];
}

class EditEmployeeEvent extends EmployeeListEvent {
  final EmployeeDetails employeeDetails;

  const EditEmployeeEvent({required this.employeeDetails});

  @override
  List<Object?> get props => [employeeDetails];
}

class DeleteEmployeeEvent extends EmployeeListEvent {
  final EmployeeDetails employeeDetails;

  const DeleteEmployeeEvent({required this.employeeDetails});

  @override
  List<Object?> get props => [employeeDetails];
}
