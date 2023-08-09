import 'dart:developer';

import 'package:eltizam_task/models/department_model.dart';
import 'package:eltizam_task/models/employee_model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';

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
  static const _employeeLastName = "Last_Name";
  static const _employeeEmail = "Email";
  static const _employeeMobileNumber = "Mobile_Number";
  static const _employeePassword = "Password";
  static const _employeeGender = "Gender";
  static const _employeeAddress = "Address";

  static const _departmentTableName = "departments";
  static const _departmentID = "ID";
  static const _departmentName = "Name";
  static const _departmentServerDateTime = "Server_Date_Time";
  static const _departmentDateTimeUTC = "DateTime_UTC";
  static const _departmentUpdateDateTimeUTC = "Update_DateTime_UTC";

  //singleton class
  DatabaseHelper._privateConstructor();

  static final instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initializeDatabase();
      return _database;
    }
  }

  //initiate database
  _initializeDatabase() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join(dir.path, _dbName);
      return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    } catch (e, s) {
      log('Error: ${e.toString()}');
      log('Stack Trace: ${s.toString()}');
      return null;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $_employeeTableName(
    $_employeeId INTEGER PRIMARY KEY AUTOINCREMENT,
    $_employeeDepartmentID INTEGER NOT NULL,
    $_employeeFirstName TEXT NOT NULL,
    $_employeeLastName TEXT NOT NULL,
    $_employeeMobileNumber TEXT NOT NULL,
    $_employeeEmail TEXT NOT NULL,
    $_employeePassword TEXT NOT NULL,
    $_employeeGender TEXT NOT NULL,
    $_employeeAddress TEXT NOT NULL,
    $_employeeServerDateTime TEXT NOT NULL,
    $_employeeDateTimeUTC TEXT NOT NULL,
    $_employeeUpdateDateTimeUTC TEXT NOT NULL)
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS  $_departmentTableName(
    $_departmentID INTEGER PRIMARY KEY,
    $_departmentName TEXT NOT NULL,
    $_departmentServerDateTime TEXT NOT NULL,
    $_departmentDateTimeUTC TEXT NOT NULL,
    $_departmentUpdateDateTimeUTC TEXT NOT NULL)
    ''');

    Map<String, dynamic> fileMap = {};
    try {
      fileMap =
          json.decode(await rootBundle.loadString('assets/data/data.json'));
      log("inserting");
      log(fileMap.toString());
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }

    for (Map<String, Object?> jsonObj in fileMap['Departments']) {
      print("inserting: ${jsonObj.toString()}");
      await db.insert(_departmentTableName, jsonObj,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (Map<String, Object?> jsonObj in fileMap['Employees']) {
      print("inserting: ${jsonObj.toString()}");
      await db.insert(_employeeTableName, jsonObj,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future _populateDBWithJson(String jsonString) async {}

  //CRUD OPS

  Future<void> insertEmployee(Map<String, dynamic> map) async {
    Database? db = await instance.database;
    await db?.insert(_employeeTableName, map,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertDepartment(Map<String, dynamic> map) async {
    Database? db = await instance.database;
    await db?.insert(_departmentTableName, map,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateEmployee(Map<String, dynamic> map, int id) async {
    Database? db = await instance.database;
    await db?.update(_employeeTableName, map,
        where: '$_employeeId = ?', whereArgs: [id]);
  }

  Future<void> updateDepartment(Map<String, dynamic> map, int id) async {
    Database? db = await instance.database;
    await db?.update(_departmentTableName, map,
        where: '$_departmentID = ?', whereArgs: [id]);
  }

  Future<void> deleteEmployee(int id) async {
    Database? db = await instance.database;
    await db?.delete(_employeeTableName,
        where: '$_employeeId = ?', whereArgs: [id]);
  }

  Future<void> deleteDepartment(int id) async {
    Database? db = await instance.database;
    await db?.delete(_departmentTableName,
        where: '$_departmentID = ?', whereArgs: [id]);
  }

  Future<Employee> getEmployee(int id) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>>? result = await db
        ?.query(_employeeTableName, where: '$_employeeId = ?', whereArgs: [id]);

    return Employee.fromJson(result?[0] ?? {});
  }

  Future<Department> getDepartment(int id) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>>? result =
        await db?.query(_departmentTableName, where: "ID = ?", whereArgs: ["$id"]);
    print(result.toString());

    return Department.fromJson(result?[0] ?? {});
  }

  Future<List<Employee>> getAllEmployees() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>>? result = await db?.query(_employeeTableName);
    List<Employee> employees = [];

    for (Map<String, dynamic> json in result ?? []) {
      employees.add(Employee.fromJson(json));
    }

    return employees;
  }

  Future<List<Department>> getAllDepartments() async {
    try {
      Database? db = await instance.database;
      List<Map<String, dynamic>>? result =
          await db?.query(_departmentTableName);
      List<Department> department = [];
      for (Map<String, dynamic> jsonObj in result ?? []) {
        department.add(Department.fromJson(jsonObj));
      }
      return department;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return [];
    }
  }
}
