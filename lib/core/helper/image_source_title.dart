import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class ImageSourceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ImageSourceTile({super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: context.appTheme.lightPink,
        child: Icon(icon, color: context.appTheme.primary),
      ),
      title: Text(
        title,
        style: context.appTheme.medium16,
      ),
      onTap: onTap,
    );
  }
}
