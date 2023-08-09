import 'package:eltizam_task/models/department_model.dart';
import 'package:eltizam_task/services/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/department_model.dart';

class DepartmentsPageProvider with ChangeNotifier {
  List<Department> _departments = [];
  List<Department> _departmentsToDelete = [];
  bool _loading = false;

  List<Department> get departments => _departments;
  List<Department> get departmentsToDelete => _departmentsToDelete;
  bool get loading => _loading;
  bool get toDeleteEmpty => _departmentsToDelete.isEmpty;

  Future<void> getDepartments() async{
    _loading = true;
    notifyListeners();
    _departments = await DatabaseHelper.instance.getAllDepartments();
    _loading = false;
    notifyListeners();
  }

  void addDepartmentToDelete(Department department){
    _departmentsToDelete.add(department);
    notifyListeners();
  }

  void removeDepartmentFromDelete(Department department){
    _departmentsToDelete.remove(department);
    notifyListeners();
  }

  Future<void> deleteDepartments() async {
    _loading = true;
    notifyListeners();
    for(Department emp in _departmentsToDelete){
      await DatabaseHelper.instance.deleteDepartment(emp.id);
    }
    _departments = await DatabaseHelper.instance.getAllDepartments();
    _departmentsToDelete.clear();
    _loading = false;
    notifyListeners();
  }
}
