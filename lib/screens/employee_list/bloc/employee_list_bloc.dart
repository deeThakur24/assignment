import 'dart:developer';

import 'package:assignment/api/app_repository.dart';
import 'package:assignment/models/employee_details/employee_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/employee_repository.dart';

part 'employee_list_event.dart';

part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final EmployeeRepository _employeeRepository = AppRepository.employeeRepository;

  EmployeeListBloc() : super(EmployeeListInitial()) {
    on<GetEmployeesEvent>(_onGetEmployeeEvent);
    on<AddEmployeeEvent>(_onAddEmployeeEvent);
    on<EditEmployeeEvent>(_onEditEmployeeEvent);
    on<DeleteEmployeeEvent>(_onDeleteEmployeeEvent);
  }

  _onGetEmployeeEvent(GetEmployeesEvent event, Emitter<EmployeeListState> emit) async {
    emit(EmployeeListLoading());

    try {
      await _employeeRepository.getEmployee();
      emit(EmployeeListSuccess());
    } catch (e) {
      log(e.toString());
      emit(const EmployeeListFailed());
    }
  }

  _onAddEmployeeEvent(AddEmployeeEvent event, Emitter<EmployeeListState> emit) async {
    emit(EmployeeListLoading());

    try {
      await _employeeRepository.addEmployee(employeeDetails: event.employeeDetails);
      emit(EmployeeListSuccess());
    } catch (e) {
      log(e.toString());
    }
  }

  _onEditEmployeeEvent(EditEmployeeEvent event, Emitter<EmployeeListState> emit) async {
    emit(EmployeeListLoading());

    try {
      await _employeeRepository.editEmployee(employeeDetails: event.employeeDetails);
      emit(EmployeeListSuccess());
    } catch (e) {
      log(e.toString());
    }
  }

  _onDeleteEmployeeEvent(DeleteEmployeeEvent event, Emitter<EmployeeListState> emit) async {
    emit(EmployeeListLoading());

    try {
      await _employeeRepository.deleteEmployee(employeeDetails: event.employeeDetails);
      emit(EmployeeListSuccess());
    } catch (e) {
      log(e.toString());
    }
  }
}
