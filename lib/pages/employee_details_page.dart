import 'package:eltizam_task/models/employee_model.dart';
import 'package:flutter/material.dart';

import '../models/department_model.dart';
import '../services/database_helper.dart';

class EmployeeDetailsPage extends StatelessWidget {
  const EmployeeDetailsPage({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.sizeOf(context).width;
    double fullHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: fullWidth,
        height: fullHeight,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Icon(Icons.person, size: 30),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("ID :"), Text("${employee.id}")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Name :"),
                Text("${employee.firstName} ${employee.lastName}")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Email :"), Text("${employee.email}")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Phone :"), Text("${employee.mobileNumber}")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date Joined :"),
                Text("${employee.serverDateTime}")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Dep. ID :"), Text("${employee.departmentID}")],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Dep. Name :"),
              FutureBuilder<Department>(
                future: DatabaseHelper.instance
                    .getDepartment(employee.departmentID),
                builder:
                    (BuildContext context, AsyncSnapshot<Department> snapshot) {
                  return Text(snapshot.data?.name ?? "");
                },
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Gender :"), Text("${employee.gender}")],
            ),
            const SizedBox(
              height: 20,
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
          ]
              .map(
                (widget) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: widget,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
