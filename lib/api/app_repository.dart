import 'package:assignment/screens/employee_list/repository/employee_repository.dart';

class AppRepository {
  /// Repository
  static final employeeRepository = EmployeeRepository();

  /// Singleton factory
  static final AppRepository _instance = AppRepository._internal();

  factory AppRepository() {
    return _instance;
  }
  AppRepository._internal();
}
