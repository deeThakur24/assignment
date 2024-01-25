import 'package:assignment/screens/employee_list/edit_employee.dart';
import 'package:assignment/screens/employee_list/employee_list.dart';
import 'package:flutter/material.dart';
import '../screens/employee_list/add_employee.dart';
import '../widgets/calender_widget.dart';
import '../widgets/reusable_widgets.dart';
import 'app_constants.dart';

class AppRouter {
  static final AppRouter _singleton = AppRouter._internal();

  AppRouter._internal();

  static AppRouter get instance => _singleton;

  /// Route Paths
  static const String routeEmployeeListPage = 'employee_list_screen';
  static const String routeAddEmployeePage = 'add_employee_screen';
  static const String routeEditEmployeePage = 'edit_employee_screen';

  /// Generating Routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeEmployeeListPage:
        return MaterialPageRoute(builder: (context) => const EmployeeList());
      case routeAddEmployeePage:
        return MaterialPageRoute(builder: (context) => const AddEmployeeScreen());
      case routeEditEmployeePage:
        final args = settings.arguments as EditEmployeeScreen;
        return MaterialPageRoute(builder: (context) => EditEmployeeScreen(employeeDetails: args.employeeDetails));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: ReusableWidgets.buildAppBar("Error", context),
        body: const Center(
          child: Text(AppConstants.errorPageNotFound),
        ),
      );
    });
  }
}
