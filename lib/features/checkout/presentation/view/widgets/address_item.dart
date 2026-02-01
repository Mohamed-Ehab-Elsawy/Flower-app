import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final String title;
  final String address;
  final bool isSelected;
  final VoidCallback onEdit;
  final VoidCallback onTap;
  final String value;

  const AddressItem({
    super.key,
    required this.title,
    required this.address,
    required this.isSelected,
    required this.onEdit,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: context.appTheme.primary, width: 2)
              : Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Radio<String>(value: value, activeColor: context.appTheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.appTheme.medium16),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: context.appTheme.regular14.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
