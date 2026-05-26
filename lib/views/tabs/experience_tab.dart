import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/portfolio_models.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_container.dart';

class ExperienceTab extends StatelessWidget {
  const ExperienceTab({super.key, required this.data});

  final PortfolioData data;

  @override
  Widget build(BuildContext context) {
    final experiences = data.experiences;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      children: [
        Text(
          'Experience',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textMain,
          ),
        ),
        const SizedBox(height: 32),
        Stack(
          children: [
            Positioned(
              left: 15,
              top: 10,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.accent,
                      AppColors.accent.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                for (var i = 0; i < experiences.length; i++)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: i < experiences.length - 1 ? 32 : 0,
                    ),
                    child: _ExperienceItem(experience: experiences[i]),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  const _ExperienceItem({required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -23,
          top: 4,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.bg,
              shape: BoxShape.circle,
              border: Border.all(
                color: experience.isActive
                    ? AppColors.accent
                    : AppColors.slate600,
                width: 2,
              ),
              boxShadow: experience.isActive
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.5),
                        blurRadius: 10,
                      ),
                    ]
                  : null,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: GlassContainer(
            borderRadius: 16,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.role,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      experience.company,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.accentLight,
                      ),
                    ),
                    Text(
                      experience.duration,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  experience.description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.slate400,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
