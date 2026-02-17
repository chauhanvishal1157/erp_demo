class EmployeeListModel {
  final int employeeId;
  final String name;
  final String mobileNo;
  final String empBioMaxDevice;
  final String categoryName;
  final String salary;
  final String salaryPayType;
  final String employeeCode;
  final String employeeProfile;
  final String employeeFace;
  final int status;
  final String ptStatus;
  final String pfStatus;
  final String esiStatus;
  final int pendingSalary;
  final String perDaySalary;
  final String todayAttendance;

  EmployeeListModel({
    required this.employeeId,
    required this.name,
    required this.mobileNo,
    required this.empBioMaxDevice,
    required this.categoryName,
    required this.salary,
    required this.salaryPayType,
    required this.employeeCode,
    required this.employeeProfile,
    required this.employeeFace,
    required this.status,
    required this.ptStatus,
    required this.pfStatus,
    required this.esiStatus,
    required this.pendingSalary,
    required this.perDaySalary,
    required this.todayAttendance,
  });

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) {
    return EmployeeListModel(
      employeeId: json['id'] ?? 0,
      name: json['name'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      empBioMaxDevice: json['emp_biomax_device'] ?? '',
      categoryName: json['category_name'] ?? '',
      salary: json['salary'] ?? '',
      salaryPayType: json['salary_pay_type'] ?? '',
      employeeCode: json['employee_code'] ?? '',
      employeeProfile: json['employee_profile'] ?? '',
      employeeFace: json['employee_face'] ?? '',
      status: json['status'] ?? 0,
      ptStatus: json['pt_status'] ?? '',
      pfStatus: json['pf_status'] ?? '',
      esiStatus: json['esi_status'] ?? '',
      pendingSalary: json['pending_salary'] ?? 0,
      perDaySalary: json['per_day_salary'] ?? '',
      todayAttendance: json['today_attendance'] ?? '',
    );
  }
}
