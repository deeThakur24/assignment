import 'package:assignment/database/database.dart';
import 'package:assignment/main.dart';
import 'package:assignment/models/employee_details/employee_details.dart';
import 'package:assignment/utils/app_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/api_constants.dart';
import '../../../utils/enums/enum.dart';

class EmployeeRepository {
  var employeeCollection = FirebaseFirestore.instance.collection(ApiConstants.employeesTable);

  Future<void> getEmployee() async {
    List<EmployeeDetails> employees = await employeeCollection
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => EmployeeDetails.fromJson(doc.data())).toList())
        .catchError((error) {
      /// ToDo: Handle Error
    });

    /// Temp list created to have track of last employees
    List<EmployeeDetails> tempCurrentEmployeeList = currentEmployeeListDb.value;
    List<EmployeeDetails> tempPreviousEmployeeList = previousEmployeeListDb.value;
    if (employees.isNotEmpty) {
      for (var element in employees) {
        EmployeeType employeeType = AppUtility.getEmployeeType(employeeDetails: element);
        if (employeeType == EmployeeType.currentEmployee) {
          tempCurrentEmployeeList.add(element);
        } else {
          tempPreviousEmployeeList.add(element);
        }
      }

      /// Finally updating the streams of employees
      currentEmployeeListDb.add(tempCurrentEmployeeList);
      previousEmployeeListDb.add(tempPreviousEmployeeList);
    } else {
      currentEmployeeListDb.add([]);
      previousEmployeeListDb.add([]);
    }
  }

  Future<void> addEmployee({required EmployeeDetails employeeDetails}) async {
    DocumentReference docRef = await employeeCollection.add(employeeDetails.toJson());
    String taskId = docRef.id;
    await employeeCollection.doc(taskId).update({'empId': taskId});
    employeeDetails.empId = taskId;
    updateEmployeeInLocal(employeeDetails: employeeDetails, operation: Operations.add);
  }

  Future<void> editEmployee({required EmployeeDetails employeeDetails}) async {
    await employeeCollection.doc(employeeDetails.empId).update(employeeDetails.toJson()).catchError(
          (error) => Fluttertoast.showToast(
              msg: "Failed: $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        );
    updateEmployeeInLocal(employeeDetails: employeeDetails, operation: Operations.edit);
  }

  Future<void> deleteEmployee({required EmployeeDetails employeeDetails}) async {
    await employeeCollection.doc(employeeDetails.empId).delete().then((value) {
      messengerKey.currentState?.hideCurrentSnackBar();
      messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: const Text('Employee data has been deleted'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                addEmployee(employeeDetails: employeeDetails);
              }),
        ),
      );
    });
    updateEmployeeInLocal(employeeDetails: employeeDetails, operation: Operations.delete);
  }

  void updateEmployeeInLocal({required EmployeeDetails employeeDetails, required Operations operation}) {
    Operations currentOperation = operation;
    EmployeeType employeeType = AppUtility.getEmployeeType(employeeDetails: employeeDetails);
    List<EmployeeDetails> tempEmployeeList = [];
    if (employeeType == EmployeeType.currentEmployee) {
      tempEmployeeList = currentEmployeeListDb.value;
      switch (currentOperation) {
        case Operations.add:
          tempEmployeeList.add(employeeDetails);
          currentEmployeeListDb.add(tempEmployeeList);
        case Operations.edit:
          tempEmployeeList[tempEmployeeList.indexWhere((element) => element.empId == employeeDetails.empId)] =
              employeeDetails;
          currentEmployeeListDb.add(tempEmployeeList);
        case Operations.delete:
          tempEmployeeList.removeWhere((element) => element.empId == employeeDetails.empId);
          currentEmployeeListDb.add(tempEmployeeList);
      }
    } else {
      tempEmployeeList = previousEmployeeListDb.value;
      switch (currentOperation) {
        case Operations.add:
          tempEmployeeList.add(employeeDetails);
          previousEmployeeListDb.add(tempEmployeeList);
        case Operations.edit:
          tempEmployeeList[tempEmployeeList.indexWhere((element) => element.empId == employeeDetails.empId)] =
              employeeDetails;
          previousEmployeeListDb.add(tempEmployeeList);
        case Operations.delete:
          tempEmployeeList.removeWhere((element) => element.empId == employeeDetails.empId);
          previousEmployeeListDb.add(tempEmployeeList);
      }
    }
  }
}
