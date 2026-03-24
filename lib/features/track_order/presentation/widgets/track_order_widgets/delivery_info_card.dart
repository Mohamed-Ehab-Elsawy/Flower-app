import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flutter/material.dart';

class DeliveryInfoCard extends StatelessWidget {
  final ActiveOrderEntity order;
  final VoidCallback? onCallTap;
  final VoidCallback? onMessageTap;

  const DeliveryInfoCard({
    super.key,
    this.onCallTap,
    this.onMessageTap,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: context.appTheme.secondary,
            child: ClipOval(
              child: Image.asset(
                order.userImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.person, color: context.appTheme.grey, size: 26),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name & subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.userName, style: context.appTheme.regular14),
                const SizedBox(height: 2),
                Text(
                  'Is your delivery hero for today',
                  style: context.appTheme.regular12.copyWith(
                    color: context.appTheme.grey,
                  ),
                ),
              ],
            ),
          ),

          _IconCircleBtn(
            icon: Icons.phone_outlined,
            color: context.appTheme.primary,
            onTap: () => onCallTap?.call(),
          ),
          const SizedBox(width: 8),

          _IconCircleBtn(
            icon: Icons.chat_outlined,
            color: context.appTheme.primary,
            onTap: () => onMessageTap?.call(),
          ),
        ],
      ),
    );
  }
}

class _IconCircleBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _IconCircleBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.1),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}
