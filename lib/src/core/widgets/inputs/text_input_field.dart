import 'package:flutter/material.dart';
import 'package:transisi/src/core/widgets/inputs/general_input_field.dart';

class TextInputField extends GeneralInputField {
  TextInputField({
    TextEditingController? controller,
    String? labelText,
    Widget? prefixIcon,
    bool? obscureText,
    Widget? suffixIcon,
    this.errorText,
    this.inputType,
  }) {
    this.controller = controller;
    this.labelText = labelText;
    this.prefixIcon = prefixIcon;
    this.obscureText = obscureText;
    this.suffixIcon = suffixIcon;
  }

  final String? errorText;
  final TextInputType? inputType;

  @override
  Widget get child => TextField(
        keyboardType: inputType,
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
        ),
      );
}
