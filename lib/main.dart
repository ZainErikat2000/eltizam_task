import 'package:eltizam_task/custom_widgets/employee_card.dart';
import 'package:eltizam_task/pages/add_employee_page.dart';
import 'package:eltizam_task/pages/departments_page.dart';
import 'package:eltizam_task/pages/employees_page.dart';
import 'package:eltizam_task/providers/departments_page_provider.dart';
import 'package:eltizam_task/providers/employee_page_provider.dart';
import 'package:eltizam_task/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/department_model.dart';
import 'models/employee_model.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(providers: [
        ListenableProvider(
            create: (context) => EmployeePageProvider()..getEmployees()),
        ListenableProvider(
            create: (context) => DepartmentsPageProvider()..getDepartments()),
      ], child: MainPage()),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();

  int selectedIndex = 0;
}

class _MainPageState extends State<MainPage> {
  List<Widget> navPages = [EmployeesPage(), DepartmentsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<EmployeePageProvider>(
        builder: (context, provider, _) {
          if (widget.selectedIndex == 0) {
            return FloatingActionButton(
              onPressed: () {
                if (provider.toDeleteEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEmployeePage(),
                    ),
                  );
                } else {
                  provider.deleteEmployees();
                }
              },
              child: provider.toDeleteEmpty
                  ? const Icon(Icons.add, size: 30)
                  : const Icon(Icons.delete, size: 30),
            );
          } else {
            return SizedBox();
          }
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<EmployeePageProvider>().getEmployees();
              },
              icon: const Icon(Icons.refresh)),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: navPages[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Employees"),
          BottomNavigationBarItem(
              icon: Icon(Icons.apartment), label: "Departments"),
        ],
        currentIndex: widget.selectedIndex,
        onTap: (index) {
          setState(() {
            widget.selectedIndex = index;
          });
        },
      ),
    );
  }
}
