import 'package:assignment/main.dart';
import 'package:assignment/models/employee_details/employee_details.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../screens/employee_list/employee_list.dart';
import '../widgets/reusable_widgets.dart';
import 'app_theme.dart';
import 'enums/enum.dart';

class AppUtility {
  showBottomSheet(context, {required List<String> roleList, required BehaviorSubject textStream}) {
    String selectedRole = 'Select role';
    List<Widget> itemList = roleList
        .map((elements) => InkWell(
              onTap: () {
                selectedRole = elements;
                navigatorKey.currentState?.pop();
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ReusableWidgets.buildDefaultTextWidget(elements,
                        textStyle: AppTheme.getInstance().textStyle16Light()),
                  ),
                  const Divider(height: 1)
                ],
              ),
            ))
        .toList();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: itemList,
          ),
        );
      },
    ).then((value) => textStream.add(selectedRole));
  }

  static EmployeeType getEmployeeType({required EmployeeDetails employeeDetails}) {
    if (employeeDetails.empToDate == '' || employeeDetails.empToDate.contains('No')) {
      return EmployeeType.currentEmployee;
    } else {
      return EmployeeType.previousEmployee;
    }
  }
}
