import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class PillMarker extends StatelessWidget {
  final IconData icon;
  final String label;

  const PillMarker({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Pill body ──────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(5, 4, 14, 4),
            decoration: BoxDecoration(
              color: context.appTheme.primary,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x44000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // white circle with icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: context.appTheme.primary, size: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          // ── Triangle tail (centred under the icon circle) ──────────────
          // left: 5 (pill left pad) + 16 (half circle width) - 8 (half tail) = 13
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: CustomPaint(
              size: const Size(16, 10),
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
