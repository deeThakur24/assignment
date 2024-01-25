// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDetails _$EmployeeDetailsFromJson(Map<String, dynamic> json) =>
    EmployeeDetails(
      empId: json['empId'] as String?,
      empName: json['empName'] as String,
      empRole: json['empRole'] as String,
      empFromDate: json['empFromDate'] as String,
      empToDate: json['empToDate'] as String,
    );

Map<String, dynamic> _$EmployeeDetailsToJson(EmployeeDetails instance) =>
    <String, dynamic>{
      'empId': instance.empId,
      'empName': instance.empName,
      'empRole': instance.empRole,
      'empFromDate': instance.empFromDate,
      'empToDate': instance.empToDate,
    };
