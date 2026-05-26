import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.name,
    required this.onComplete,
  });

  final String name;
  final VoidCallback onComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeOut;
  late final Animation<double> _spin1;
  late final Animation<double> _spin2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _fadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );
    _spin1 = Tween<double>(begin: 0, end: 1).animate(_controller);
    _spin2 = Tween<double>(begin: 0, end: -1).animate(_controller);

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) _controller.forward();
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeOut,
      child: Container(
        color: AppColors.bg,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 96,
                height: 96,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _spin1,
                      builder: (context, child) => Transform.rotate(
                        angle: _spin1.value * 6.28,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border(
                              top: BorderSide(
                                color: AppColors.accent.withValues(alpha: 0.2),
                                width: 2,
                              ),
                              right: BorderSide(
                                color: AppColors.accent.withValues(alpha: 0.2),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _spin2,
                      builder: (context, child) => Transform.rotate(
                        angle: _spin2.value * 6.28,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.accentLight.withValues(alpha: 0.4),
                                width: 2,
                              ),
                              left: BorderSide(
                                color: AppColors.accentLight.withValues(alpha: 0.4),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.code, color: AppColors.accent, size: 40),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.name,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'PORTFOLIO',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.accentLight,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
