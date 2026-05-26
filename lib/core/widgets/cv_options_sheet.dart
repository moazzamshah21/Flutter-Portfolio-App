import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'glass_container.dart';

class CvOptionsSheet extends StatelessWidget {
  const CvOptionsSheet({
    super.key,
    required this.onDownload,
    required this.onView,
  });

  final VoidCallback onDownload;
  final VoidCallback onView;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onDownload,
    required VoidCallback onView,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CvOptionsSheet(
        onDownload: () {
          Navigator.pop(context);
          onDownload();
        },
        onView: () {
          Navigator.pop(context);
          onView();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: GlassContainer(
        borderRadius: 24,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resume / CV',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Download or view Moazzam Shah Khan\'s full resume.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.slate400,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            _OptionTile(
              icon: Icons.download_rounded,
              label: 'Download CV',
              subtitle: 'Save or share PDF',
              onTap: onDownload,
            ),
            const SizedBox(height: 12),
            _OptionTile(
              icon: Icons.description_outlined,
              label: 'View Full Resume',
              subtitle: 'Open in-app PDF viewer',
              onTap: onView,
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: AppColors.accentLight, size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMain,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.slate500,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
