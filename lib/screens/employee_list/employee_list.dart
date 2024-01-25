import 'package:assignment/database/database.dart';
import 'package:assignment/main.dart';
import 'package:assignment/models/employee_details/employee_details.dart';
import 'package:assignment/screens/employee_list/bloc/employee_list_bloc.dart';
import 'package:assignment/screens/employee_list/edit_employee.dart';
import 'package:assignment/utils/app_router.dart';
import 'package:assignment/utils/navigator_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../utils/app_theme.dart';
import '../../utils/assets.dart';
import '../../widgets/reusable_widgets.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  EmployeeListBloc employeeListBloc = EmployeeListBloc();

  @override
  void initState() {
    employeeListBloc.add(const GetEmployeesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.buildAppBar('Employee List', context),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          onPressed: () {
            NavigationService().navigatePushNamed(AppRouter.routeAddEmployeePage);
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
        bloc: employeeListBloc,
        buildWhen: (prevState, currState) => currState is EmployeeListSuccess,
        builder: (context, state) {
          if (state is EmployeeListSuccess) {
            return employeeList();
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget employeeList() {
    return StreamBuilder<List<EmployeeDetails>>(
      stream: currentEmployeeListDb.stream,
      builder: (context, snapshot) {
        return StreamBuilder<List<EmployeeDetails>>(
          stream: previousEmployeeListDb.stream,
          builder: (context, snapshot) {
            return Visibility(
              visible: currentEmployeeListDb.hasValue && currentEmployeeListDb.value.isNotEmpty ||
                  previousEmployeeListDb.hasValue && previousEmployeeListDb.value.isNotEmpty,
              replacement: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableWidgets.createSVG(assetName: Assets.instance.noEmployee, size: 180),
                    ReusableWidgets.buildDefaultTextWidget('No employee records found',
                        textStyle: AppTheme.getInstance().textStyle18())
                  ],
                ),
              ),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Visibility(
                          visible: currentEmployeeListDb.hasValue && currentEmployeeListDb.value.isNotEmpty,
                          child: listContainer(title: 'Current employees')),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((BuildContext context, int index) {
                            EmployeeDetails employee = currentEmployeeListDb.value[index];
                            return InkWell(
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(AppRouter.routeEditEmployeePage,
                                    arguments: EditEmployeeScreen(employeeDetails: employee));
                              },
                              child: Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.2,
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) => deleteEmployee(employeeDetails: employee),
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: SizedBox(
                                  height: 104,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ReusableWidgets.buildDefaultTextWidget(
                                          employee.empName,
                                          textStyle: AppTheme.getInstance().textStyle16(color: AppTheme.textColor),
                                        ),
                                        const SizedBox(height: 6),
                                        ReusableWidgets.buildDefaultTextWidget(
                                          employee.empRole,
                                          textStyle: AppTheme.getInstance().textStyle14(color: AppTheme.greyTextColor),
                                        ),
                                        const SizedBox(height: 6),
                                        ReusableWidgets.buildDefaultTextWidget(
                                          'From ${employee.empFromDate}',
                                          textStyle: AppTheme.getInstance().textStyle12(color: AppTheme.greyTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          separatorBuilder: ((BuildContext context, int index) {
                            return const Divider(height: 0);
                          }),
                          itemCount: currentEmployeeListDb.value.length),
                      Visibility(
                          visible: previousEmployeeListDb.hasValue && previousEmployeeListDb.value.isNotEmpty,
                          child: listContainer(title: 'Previous employees')),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: ((BuildContext context, int index) {
                          EmployeeDetails employee = previousEmployeeListDb.value[index];
                          return InkWell(
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(AppRouter.routeEditEmployeePage,
                                  arguments: EditEmployeeScreen(employeeDetails: employee));
                            },
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.2,
                                children: [
                                  SlidableAction(
                                    onPressed: (context) => deleteEmployee(employeeDetails: employee),
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                height: 104,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ReusableWidgets.buildDefaultTextWidget(
                                        employee.empName,
                                        textStyle: AppTheme.getInstance().textStyle16(color: AppTheme.textColor),
                                      ),
                                      const SizedBox(height: 6),
                                      ReusableWidgets.buildDefaultTextWidget(
                                        employee.empRole,
                                        textStyle: AppTheme.getInstance().textStyle14(color: AppTheme.greyTextColor),
                                      ),
                                      const SizedBox(height: 6),
                                      ReusableWidgets.buildDefaultTextWidget(
                                        '${employee.empFromDate} - ${employee.empToDate}',
                                        textStyle: AppTheme.getInstance().textStyle12(color: AppTheme.greyTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        separatorBuilder: ((BuildContext context, int index) {
                          return const Divider(height: 0);
                        }),
                        itemCount: previousEmployeeListDb.value.length,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: AppTheme.greyTextColor.withOpacity(0.2),
                      padding: const EdgeInsets.all(16),
                      child: ReusableWidgets.buildDefaultTextWidget(
                        'Swipe left to delete',
                        textStyle: AppTheme.getInstance().textStyle15(color: AppTheme.greyTextColor),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget listContainer({required String title}) {
    return Container(
      height: 56,
      color: AppTheme.greyTextColor.withOpacity(0.2),
      padding: const EdgeInsets.all(16),
      child: ReusableWidgets.buildDefaultTextWidget(
        title,
        textStyle: AppTheme.getInstance().textStyle16(color: AppTheme.darkBlueColor),
      ),
    );
  }

  void deleteEmployee({required EmployeeDetails employeeDetails}) {
    employeeListBloc.add(DeleteEmployeeEvent(employeeDetails: employeeDetails));
  }
}
