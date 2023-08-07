class Employee {
  Employee(
      {required this.id,
      required this.departmentID,
      required this.serverDateTime,
      required this.dateTimeUTC,
      required this.updateDateTimeUTC,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobileNumber,
      required this.password,
      required this.gender,
      required this.address});

  final int id;
  final int departmentID;
  final String serverDateTime;
  final String dateTimeUTC;
  final String updateDateTimeUTC;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String password;
  final String gender;
  final String address;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      id: json["ID"],
      departmentID: json["Department_ID"],
      serverDateTime: json["Server_Date_Time"],
      dateTimeUTC: json["DateTime_UTC"],
      updateDateTimeUTC: json["Update_DateTime_UTC"],
      firstName: json["First_Name"],
      lastName: json["Last_Name"],
      email: json["Email"],
      mobileNumber: json["Mobile_Number"],
      password: json["Password"],
      gender: json["Gender"],
      address: json["Address"]);

  factory Employee.toJson(Employee employee) => {};
}
