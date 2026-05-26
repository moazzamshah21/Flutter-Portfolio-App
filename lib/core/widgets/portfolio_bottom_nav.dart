import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'glass_container.dart';

enum PortfolioTab { home, projects, experience, profile }

class PortfolioBottomNav extends StatelessWidget {
  const PortfolioBottomNav({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  final PortfolioTab currentTab;
  final ValueChanged<PortfolioTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      navStyle: true,
      borderRadius: 24,
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: 'Home',
              isActive: currentTab == PortfolioTab.home,
              onTap: () => onTabSelected(PortfolioTab.home),
            ),
            _NavItem(
              icon: Icons.grid_view_rounded,
              label: 'Work',
              isActive: currentTab == PortfolioTab.projects,
              onTap: () => onTabSelected(PortfolioTab.projects),
            ),
            _NavItem(
              icon: Icons.schedule_rounded,
              label: 'Timeline',
              isActive: currentTab == PortfolioTab.experience,
              onTap: () => onTabSelected(PortfolioTab.experience),
            ),
            _NavItem(
              icon: Icons.person_rounded,
              label: 'Profile',
              isActive: currentTab == PortfolioTab.profile,
              onTap: () => onTabSelected(PortfolioTab.profile),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.accentLight : AppColors.slate500;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
