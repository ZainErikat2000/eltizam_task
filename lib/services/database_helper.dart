import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static const _dbName = "eltisam.db";
  static const _dbVersion = 1;

  //TABLES
  static const _employeeTableName = "employees";
  static const _employeeId = 'ID';
  static const _employeeDepartmentID = "Department_ID";
  static const _employeeServerDateTime = "Server_Date_Time";
  static const _employeeDateTimeUTC = "DateTime_UTC";
  static const _employeeUpdateDateTimeUTC = "Update_DateTime_UTC";
  static const _employeeFirstName = "First_Name";
  static const _employeeLastName = "last_Name";
  static const _employeeEmail = "Email";
  static const _employeeMobileNumber ="Mobile_Number";
  static const _employeePassword = "Password";
  static const _employeeGender = "Gender";
  static const _employeeAddress = "Address";


  static const _departmentTableName = "departments";
  static const _departmentID = "ID";
  static const _departmentName = "Name";
  static const _departmentServerDateTime ="Server_Date_Time";
  static const _departmentDateTimeUTC = "DateTime_UTC";
  static const _departmentUpdateDateTimeUTC = "Update_DateTime_UTC";

  //singleton class
  DatabaseHelper._privateConstructor();
  static final instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if(_database != null){
      return _database;
    }else{
      _database = await _initializeDatabase();
      return _database;
    }
  }

  //initiate database
  _initializeDatabase () async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path,_dbName);
    await openDatabase(path,version: _dbVersion,onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.query('''
    
    ''');
  }
}