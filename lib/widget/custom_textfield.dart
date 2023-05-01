import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.labletxt,
    this.validator,
    required this.obscure,
  });

  final TextEditingController controller;
  final String labletxt;
  FormFieldValidator<String>? validator;
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusColor: Colors.green,
        labelText: labletxt,
      ),
    );
  }
}
