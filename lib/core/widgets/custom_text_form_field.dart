import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
    this.obscureText,
    this.validator,
    this.onChanged,
    this.controller,
    this.suffixIcon,
    this.enabled,
  });

  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool? enabled;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      controller: controller,

      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.always,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),

          borderSide: const BorderSide(style: BorderStyle.solid),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
