import 'package:json_annotation/json_annotation.dart'; 

part 'employee_details.g.dart'; 

@JsonSerializable(ignoreUnannotated: false)
class EmployeeDetails {
  @JsonKey(name: 'empId')
  String? empId;
  @JsonKey(name: 'empName')
  String empName;
  @JsonKey(name: 'empRole')
  String empRole;
  @JsonKey(name: 'empFromDate')
  String empFromDate;
  @JsonKey(name: 'empToDate')
  String empToDate;

  EmployeeDetails({this.empId,required this.empName, required this.empRole, required this.empFromDate, required this.empToDate});

   factory EmployeeDetails.fromJson(Map<String, dynamic> json) => _$EmployeeDetailsFromJson(json);

   Map<String, dynamic> toJson() => _$EmployeeDetailsToJson(this);
}

