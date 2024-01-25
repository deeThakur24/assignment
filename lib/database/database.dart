library app_database;

import 'package:assignment/models/employee_details/employee_details.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<List<EmployeeDetails>> currentEmployeeListDb = BehaviorSubject.seeded([]);
BehaviorSubject<List<EmployeeDetails>> previousEmployeeListDb = BehaviorSubject.seeded([]);
