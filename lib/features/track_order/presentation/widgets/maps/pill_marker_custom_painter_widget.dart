import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flutter/material.dart';

class PillMarkerCustomPainterWidget extends StatelessWidget {
  final IconData icon;
  final String label;

  const PillMarkerCustomPainterWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(3, 2, 8, 2),
            decoration: BoxDecoration(
              color: context.appTheme.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: context.appTheme.primary, size: 11),
                ),
                context.w(4),
                Text(
                  label,
                  style: context.appTheme.regular12.copyWith(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 9),
            child: CustomPaint(
              size: const Size(6, 5),
              painter: _TrianglePainter(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final BuildContext context;
  const _TrianglePainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(size.width / 2, size.height)
        ..lineTo(size.width, 0)
        ..close(),
      Paint()..color = context.appTheme.primary,
    );
  }

  @override
  bool shouldRepaint(_TrianglePainter _) => false;
}
