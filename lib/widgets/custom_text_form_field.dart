import 'package:flutter/material.dart';
import 'package:mobilesoftware/core/utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final LoginInputType inputType;
  final Widget? suffixIcon;
  final TextEditingController? controller; // Add controller parameter

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    required this.inputType,
    this.onSaved,
    this.validator,
    this.suffixIcon,
    this.controller, // Initialize controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Use the provided controller
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
      keyboardType: inputType == LoginInputType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
    );
  }
}