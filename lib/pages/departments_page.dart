import 'package:eltizam_task/models/department_model.dart';
import 'package:eltizam_task/providers/departments_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/department_card.dart';
import '../custom_widgets/employee_card.dart';
import '../providers/employee_page_provider.dart';

class DepartmentsPage extends StatelessWidget {
  const DepartmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        child: Consumer<DepartmentsPageProvider>(
          builder: (context, provider, _) {
            return provider.loading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: provider.departments
                    .map(
                      (department) => DepartmentCard(
                    department: department,
                    onLongPress: () {
                      provider.addDepartmentToDelete(department);
                    },
                    onLongPressReversal: () {
                      provider.removeDepartmentFromDelete(department);
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
