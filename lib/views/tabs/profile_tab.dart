import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/portfolio_models.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_container.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    super.key,
    required this.data,
    required this.isLiked,
    required this.onCvTap,
    required this.onEmailTap,
    required this.onLinkedInTap,
    required this.onGithubTap,
    required this.onPhoneTap,
    required this.onLikeTap,
  });

  final PortfolioData data;
  final bool isLiked;
  final VoidCallback onCvTap;
  final VoidCallback onEmailTap;
  final VoidCallback onLinkedInTap;
  final VoidCallback onGithubTap;
  final VoidCallback onPhoneTap;
  final VoidCallback onLikeTap;

  @override
  Widget build(BuildContext context) {
    final data = this.data;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      children: [
        Text(
          'About & Skills',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textMain,
          ),
        ),
        const SizedBox(height: 24),
        GlassContainer(
          borderRadius: 24,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.about,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.slate300,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: onCvTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.description_outlined,
                        color: AppColors.accentLight,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Download or View CV',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accentLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Technical Arsenal',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textMain,
          ),
        ),
        const SizedBox(height: 16),
        ...data.skills.map((skill) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      skill.name,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.slate300,
                      ),
                    ),
                    Text(
                      '${skill.proficiency}%',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.accentLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: skill.proficiency / 100,
                    minHeight: 8,
                    backgroundColor: AppColors.slate800,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.accentLight,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        Text(
          "Let's Connect",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textMain,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.3,
          children: [
            _ContactButton(
              label: 'Email Me',
              icon: Icons.mail_outline,
              iconColor: AppColors.accentLight,
              iconBg: AppColors.accent.withValues(alpha: 0.2),
              onTap: onEmailTap,
            ),
            _ContactButton(
              label: 'LinkedIn',
              icon: Icons.business_center_outlined,
              iconColor: AppColors.linkedIn,
              iconBg: AppColors.linkedIn.withValues(alpha: 0.2),
              onTap: onLinkedInTap,
            ),
            _ContactButton(
              label: 'GitHub',
              icon: Icons.code,
              iconColor: Colors.white,
              iconBg: Colors.white.withValues(alpha: 0.1),
              onTap: onGithubTap,
            ),
            _ContactButton(
              label: 'Phone',
              icon: Icons.phone_outlined,
              iconColor: AppColors.green500,
              iconBg: AppColors.green500.withValues(alpha: 0.2),
              onTap: onPhoneTap,
            ),
          ],
        ),
        const SizedBox(height: 32),
        Center(
          child: GestureDetector(
            onTap: onLikeTap,
            child: GlassContainer(
              borderRadius: 999,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: isLiked
                    ? BoxDecoration(
                        color: AppColors.pink400.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(999),
                      )
                    : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? AppColors.pink400 : AppColors.slate300,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Like Portfolio',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: isLiked ? AppColors.pink400 : AppColors.slate300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textMain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
