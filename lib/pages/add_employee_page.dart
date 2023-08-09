import 'package:eltizam_task/custom_widgets/custom_text_form.dart';
import 'package:eltizam_task/models/department_model.dart';
import 'package:flutter/material.dart';
import '../services/database_helper.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery
        .sizeOf(context)
        .width;
    double fullHeight = MediaQuery
        .sizeOf(context)
        .height;

    final formKey = GlobalKey<FormState>();

    String fName = "";
    String lName = "";
    String email = "";
    String phone = "";
    String gender = "Male";
    String address = "";
    String password = "";
    int dep_id = 0;

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: fullWidth,
        height: fullHeight,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFormField(
                  label: "First Name",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "PLease fill the field";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    fName = value ?? "";
                  },
                ),
                CustomTextFormField(
                  label: "Last Name",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "PLease fill the field";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    lName = value ?? "";
                  },
                ),
                CustomTextFormField(
                  label: "Email",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "PLease fill the field";
                    }
                    if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value ?? "")) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    email = value ?? "";
                  },
                ),
                CustomTextFormField(
                  label: "Phone",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "PLease fill the field";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    phone = value ?? "";
                  },
                ),
                DropdownButtonFormField<String>(
                  items: ["Male", "Female"]
                      .map((e) =>
                      DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ))
                      .toList(),
                  onChanged: (value) {
                    gender = value ?? "";
                  },
                  decoration: const InputDecoration(
                    label: Text("Gender"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please pick a gender";
                    }
                    return null;
                  },
                ),
                FutureBuilder<List<Department>>(
                    future: DatabaseHelper.instance.getAllDepartments(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else {
                        return DropdownButtonFormField<Department>(
                          items: snapshot.data
                              ?.map((e) =>
                              DropdownMenuItem<Department>(
                                value: e,
                                child: Text(e.name),
                              ))
                              .toList(),
                          onChanged: (value) {
                            dep_id = value!.id;
                          },
                          decoration: const InputDecoration(
                            label: Text("Department"),
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 2, color: Colors.blue),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "please pick a department";
                            }
                            return null;
                          },
                        );
                      }
                    }),
                CustomTextFormField(
                  label: "Address",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "PLease fill the field";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    address = value ?? "";
                  },
                ),
                CustomTextFormField(
                  label: "Password",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "PLease fill the field";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    password = value ?? "";
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        Map<String, dynamic> data = {
                          "First_Name": fName,
                          "Last_Name": lName,
                          "Gender": gender,
                          "Address": address,
                          "Mobile_Number": phone,
                          "Email": email,
                          "Password": password,
                          "Department_ID": dep_id,
                          "Server_Date_Time": "2020-2-2",
                          "DateTime_UTC": "2020-2-2",
                          "Update_DateTime_UTC": "2020-2-2",
                        };

                        print(data.toString());

                        await DatabaseHelper.instance.insertEmployee(data);
                      }
                    },
                    child: const Text("Add Employee"))
              ]
                  .map(
                    (e) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: e,
                    ),
              )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
