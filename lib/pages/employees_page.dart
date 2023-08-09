import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/employee_card.dart';
import '../providers/employee_page_provider.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        child: Consumer<EmployeePageProvider>(
          builder: (context, provider, _) {
            return provider.loading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: provider.employees
                    .map(
                      (employee) => EmployeeCard(
                    employee: employee,
                    onLongPress: () {
                      print(employee.firstName);
                      provider.addEmployeeToDelete(employee);
                    },
                    onLongPressReversal: () {
                      provider.removeEmployeeFromDelete(employee);
                    },
                  ),
                )
                    .toList());
          },
        ),
      ),
    );
  }
}
