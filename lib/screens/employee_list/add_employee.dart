import 'package:assignment/main.dart';
import 'package:assignment/models/employee_details/employee_details.dart';
import 'package:assignment/screens/employee_list/bloc/employee_list_bloc.dart';
import 'package:assignment/utils/app_theme.dart';
import 'package:assignment/utils/app_utility.dart';
import 'package:assignment/widgets/calender_widget.dart';
import 'package:assignment/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/assets.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  EmployeeListBloc employeeListBloc = EmployeeListBloc();
  final TextEditingController employeeNameController = TextEditingController();
  final FocusNode employeeNameNode = FocusNode();
  BehaviorSubject<String> employeeRole = BehaviorSubject();
  BehaviorSubject<String> employeeFromDate = BehaviorSubject();
  BehaviorSubject<String> employeeToDate = BehaviorSubject();

  DateTime selectedDate = DateTime.now();
  final List<String> _rolesList = ['Product Designer', 'Flutter Developer', 'QA Tester', 'Product Owner'];

  @override
  void initState() {
    employeeRole.sink.add('Select role');
    employeeFromDate.sink.add('No date');
    employeeToDate.sink.add('No date');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.buildAppBar('Add Employee Details', context),
      bottomNavigationBar: ReusableWidgets.bottomNavBar(() {
        addEmployee(
          EmployeeDetails(
            empId: '',
            empName: employeeNameController.text,
            empRole: employeeRole.value,
            empFromDate: employeeFromDate.value,
            empToDate: employeeToDate.value,
          ),
        );
        navigatorKey.currentState?.pop();
      }),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: Form(
          child: Column(
            children: <Widget>[
              ReusableWidgets.formFieldContainer(
                body: Row(
                  children: [
                    ReusableWidgets.createSVG(assetName: Assets.instance.person, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: employeeNameController,
                        focusNode: employeeNameNode,
                        style: AppTheme.getInstance().textStyle16Light(),
                        decoration: AppTheme.getInstance().textFieldDecoration(hintTextStyle: 'Employee name'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),

              ///Employee Role DropDown
              ReusableWidgets.createTextField(
                showRoleBottomSheet,
                textStream: employeeRole,
                leadingIconPath: Assets.instance.work,
                isDropDown: true,
              ),
              const SizedBox(height: 23),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    ///Employee From Date
                    Expanded(
                      child: ReusableWidgets.createTextField(
                        () => openCalendar(employeeFromDate),
                        textStream: employeeFromDate,
                        leadingIconPath: Assets.instance.calendar,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ReusableWidgets.createSVG(assetName: Assets.instance.arrowRight, size: 24),
                    ),

                    ///Employee To Date
                    Expanded(
                      child: ReusableWidgets.createTextField(
                        () => openCalendar(employeeToDate),
                        textStream: employeeToDate,
                        leadingIconPath: Assets.instance.calendar,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openCalendar(BehaviorSubject<String> textStream) {
    if (employeeNameNode.hasPrimaryFocus) {
      employeeNameNode.unfocus();
    }
    CalendarScreen().getCalendar(context, textStream: textStream);
  }

  void showRoleBottomSheet() {
    if (employeeNameNode.hasPrimaryFocus) {
      employeeNameNode.unfocus();
    }
    AppUtility().showBottomSheet(context, roleList: _rolesList, textStream: employeeRole);
  }

  void addEmployee(EmployeeDetails employeeDetails) {
    employeeListBloc.add(AddEmployeeEvent(employeeDetails: employeeDetails));
  }
}
