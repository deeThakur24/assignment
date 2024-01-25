import 'package:assignment/main.dart';
import 'package:assignment/models/employee_details/employee_details.dart';
import 'package:assignment/screens/employee_list/bloc/employee_list_bloc.dart';
import 'package:assignment/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/app_theme.dart';
import '../../utils/app_utility.dart';
import '../../utils/assets.dart';
import '../../widgets/calender_widget.dart';

class EditEmployeeScreen extends StatefulWidget {
  final EmployeeDetails employeeDetails;
  const EditEmployeeScreen({super.key, required this.employeeDetails});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
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
    employeeNameController.text = widget.employeeDetails.empName;
    employeeRole.sink.add(widget.employeeDetails.empRole);
    employeeFromDate.sink.add(widget.employeeDetails.empFromDate);
    employeeToDate.sink.add(widget.employeeDetails.empToDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.buildAppBar('Edit Employee Details', context),
      bottomNavigationBar: ReusableWidgets.bottomNavBar(() {
        editEmployee(
          EmployeeDetails(
            empId: widget.employeeDetails.empId,
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

  void editEmployee(EmployeeDetails employeeDetails) {
    employeeListBloc.add(EditEmployeeEvent(employeeDetails: employeeDetails));
  }
}
