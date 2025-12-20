import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.textOnButton,
    this.onPressed,
    this.child,
    this.borderRadius,
  });
  final String textOnButton;
  final void Function()? onPressed;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        disabledBackgroundColor: Theme.of(context).disabledColor,
        minimumSize: Size(double.infinity, 48),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(24.0),
        ),
      ),
      child: Text(
        textOnButton,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
