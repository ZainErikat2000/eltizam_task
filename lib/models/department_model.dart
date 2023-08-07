class Department {
  Department(
      {required this.id,
      required this.name,
      required this.serverDateTime,
      required this.dateTimeUTC,
      required this.updateDateTimeUTC});

  final int id;
  final String name;
  final String serverDateTime;
  final String dateTimeUTC;
  final String updateDateTimeUTC;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
      id: json['ID'],
      name: json['Name'],
      serverDateTime: json["Server_Date_Time"],
      dateTimeUTC: json["DateTime_UTC"],
      updateDateTimeUTC: json["Update_DateTime_UTC"]);
}
