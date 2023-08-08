import 'package:eltizam_task/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/department_model.dart';
import 'models/employee_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () async {
          print(await DatabaseHelper.instance.getAllEmployees());
        }, child: Text("click me")),
      ),
    );
  }
}
