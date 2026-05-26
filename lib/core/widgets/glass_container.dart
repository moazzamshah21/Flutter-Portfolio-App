import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding,
    this.navStyle = false,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool navStyle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: navStyle ? 20 : 16,
          sigmaY: navStyle ? 20 : 16,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: navStyle
                ? AppColors.bg.withValues(alpha: 0.8)
                : AppColors.cardBg,
            border: Border.all(
              color: navStyle
                  ? Colors.white.withValues(alpha: 0.05)
                  : AppColors.cardBorder,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
