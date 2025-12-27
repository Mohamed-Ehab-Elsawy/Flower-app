import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final String? label;
  final double? borderRadius;
  final BorderSide? borderSide;
  final OutlineInputBorder? outlineInputBorder;
  final Widget? suffixIcon;
  final bool? isObscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? enabled;
  final String? suffixTest;
  final VoidCallback? onTap;
  const CustomTextFromField({
    super.key,
    required this.hintText,
    this.hintStyle,
    this.borderRadius,
    this.borderSide,
    this.outlineInputBorder,
    this.suffixIcon,
    this.isObscureText,
    required this.label,
    this.controller,
    this.validator,
    this.enabled,
    this.suffixTest,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: enabled ?? false,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        suffix: InkWell(
          onTap: onTap,
          child: Text(suffixTest ?? '', ),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText,
        hintStyle:
            hintStyle ??
            const TextStyle(
              fontSize: 14,
              color: Color(0xFF535353),
              fontWeight: FontWeight.w400,
            ),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF535353),
          fontWeight: FontWeight.w400,
        ),
        enabledBorder:
            outlineInputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 4),
              borderSide:
                  borderSide ?? const BorderSide(color: Color(0xFF535353), width: 1),
            ),
        focusedBorder:
            outlineInputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 4),
              borderSide:
                  borderSide ?? const BorderSide(color: Color(0xFF535353), width: 1),
            ),
        disabledBorder:
            outlineInputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 4),
              borderSide:
                  borderSide ?? const BorderSide(color: Color(0xFF535353), width: 1),
            ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          borderSide:
              borderSide ?? const BorderSide(color: Color(0xFFCC1010), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          borderSide:
              borderSide ?? const BorderSide(color: Color(0xFFCC1010), width: 1),
        ),

        suffixIcon: suffixIcon,
      ),
      obscureText: isObscureText ?? false,
      cursorColor: const Color(0xFF535353),
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF535353),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
