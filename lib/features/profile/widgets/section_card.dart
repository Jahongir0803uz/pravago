import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';

class SectionCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final bool isInset;
  final VoidCallback? onTap;

  const SectionCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 20,
    this.isInset = false,
    this.onTap,
  });

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(widget.borderRadius.r);
    final inset = widget.isInset || _pressed;

    final base = isDark ? AppColors.blue950 : AppColors.white;

    final lightShadow = isDark
        ? AppColors.blue900.withValues(alpha: 0.6)
        : AppColors.white;

    final darkShadow = isDark
        ? AppColors.black.withValues(alpha: 0.8)
        : AppColors.blue200.withValues(alpha: 0.5);

    final surfaceTop = isDark
        ? Color.lerp(base, AppColors.blue900, 0.45)!
        : base;
    final surfaceBottom = isDark
        ? Color.lerp(base, AppColors.black, 0.25)!
        : Color.lerp(base, AppColors.blue200, 0.18)!;

    final gradientColors = inset
        ? [surfaceBottom, surfaceTop]
        : [surfaceTop, surfaceBottom];

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: inset
            ? const []
            : [
                BoxShadow(
                  color: lightShadow,
                  offset: const Offset(-6, -6),
                  blurRadius: 12,
                ),
                BoxShadow(
                  color: darkShadow,
                  offset: const Offset(6, 6),
                  blurRadius: 12,
                ),
              ],
      ),
      child: CustomPaint(
        painter: inset
            ? _InsetShadowPainter(
                radius: radius,
                darkShadow: darkShadow,
                lightShadow: lightShadow,
                blur: 8,
                offset: 4,
              )
            : null,
        child: Padding(
          padding: widget.padding ?? AppPadding.pA14,
          child: widget.child,
        ),
      ),
    );

    return Padding(
      padding: widget.margin ?? EdgeInsets.symmetric(vertical: 10.h),
      child: widget.onTap == null
          ? card
          : GestureDetector(
              onTapDown: (_) => _setPressed(true),
              onTapUp: (_) => _setPressed(false),
              onTapCancel: () => _setPressed(false),
              onTap: widget.onTap,
              child: card,
            ),
    );
  }
}

class _InsetShadowPainter extends CustomPainter {
  final BorderRadius radius;
  final Color darkShadow;
  final Color lightShadow;
  final double blur;
  final double offset;

  const _InsetShadowPainter({
    required this.radius,
    required this.darkShadow,
    required this.lightShadow,
    required this.blur,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = radius.toRRect(rect);

    canvas.save();
    canvas.clipRRect(rrect);

    _drawInner(canvas, rect, rrect, darkShadow, Offset(offset, offset));
    _drawInner(canvas, rect, rrect, lightShadow, Offset(-offset, -offset));

    canvas.restore();
  }

  void _drawInner(
    Canvas canvas,
    Rect rect,
    RRect rrect,
    Color color,
    Offset shift,
  ) {
    final outer = Path()..addRect(rect.inflate(blur * 3 + shift.distance));
    final hole = Path()..addRRect(rrect.shift(shift));
    final frame = Path.combine(PathOperation.difference, outer, hole);

    canvas.drawPath(
      frame,
      Paint()
        ..color = color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _InsetShadowPainter old) =>
      old.radius != radius ||
      old.darkShadow != darkShadow ||
      old.lightShadow != lightShadow ||
      old.blur != blur ||
      old.offset != offset;
}
