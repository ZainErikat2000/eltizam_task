import 'package:eltizam_task/services/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/employee_model.dart';

class EmployeePageProvider with ChangeNotifier {
  List<Employee> _employees = [];
  List<Employee> _employeesToDelete = [];
  bool _loading = false;

  List<Employee> get employees => _employees;
  List<Employee> get employeesToDelete => _employeesToDelete;
  bool get loading => _loading;
  bool get toDeleteEmpty => _employeesToDelete.isEmpty;

  Future<void> getEmployees() async{
    _loading = true;
    notifyListeners();
    _employees = await DatabaseHelper.instance.getAllEmployees();
    _loading = false;
    notifyListeners();
  }

  void addEmployeeToDelete(Employee employee){
    _employeesToDelete.add(employee);
    notifyListeners();
  }

  void removeEmployeeFromDelete(Employee employee){
    _employeesToDelete.remove(employee);
    notifyListeners();
  }

  Future<void> deleteEmployees() async {
    _loading = true;
    notifyListeners();
    for(Employee emp in _employeesToDelete){
      await DatabaseHelper.instance.deleteEmployee(emp.id);
    }
    _employees = await DatabaseHelper.instance.getAllEmployees();
    _employeesToDelete.clear();
    _loading = false;
    notifyListeners();
  }
}
