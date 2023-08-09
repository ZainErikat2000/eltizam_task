import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, required this.label, required this.validator, required this.onChanged});

  final String label;
  final String? Function(String?) validator;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(label: Text(label),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.blue),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
