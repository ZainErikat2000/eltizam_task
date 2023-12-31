import 'package:eltizam_task/pages/employee_details_page.dart';
import 'package:flutter/material.dart';

import '../models/employee_model.dart';

class EmployeeCard extends StatefulWidget {
  EmployeeCard({
    super.key,
    required this.employee,
    required this.onLongPress,
    required this.onLongPressReversal,
  });

  final Employee employee;
  final void Function() onLongPress;
  final void Function() onLongPressReversal;

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isChecked
          ? () {
              setState(() {
                isChecked = !isChecked;
              });
              //IMPLEMENT REMOVAL
              widget.onLongPressReversal();
            }
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeDetailsPage(
                    employee: widget.employee,
                  ),
                ),
              );
            },
      onLongPress: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onLongPress();
      },
      child: Container(
        child: Container(
          height: 100,
          width: MediaQuery.sizeOf(context).width * .9,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isChecked
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
              Container(
                width: MediaQuery.sizeOf(context).width * .7,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Name: ${widget.employee.firstName} ${widget.employee.lastName}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Email: ${widget.employee.email}"),
                    Text("Dep. ID: ${widget.employee.departmentID}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
