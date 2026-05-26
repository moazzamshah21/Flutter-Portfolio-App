import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/state/portfolio_ui_state.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/portfolio_bottom_nav.dart';
import '../core/widgets/cv_options_sheet.dart';
import '../core/widgets/project_detail_modal.dart';
import '../core/widgets/splash_screen.dart';
import '../core/widgets/toast_overlay.dart';
import 'resume_viewer_screen.dart';
import '../models/portfolio_models.dart';
import '../viewmodels/portfolio_view_model.dart';
import 'tabs/experience_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/profile_tab.dart';
import 'tabs/projects_tab.dart';

class _ProjectModalSlide extends StatefulWidget {
  const _ProjectModalSlide({super.key, required this.child});

  final Widget child;

  @override
  State<_ProjectModalSlide> createState() => _ProjectModalSlideState();
}

class _ProjectModalSlideState extends State<_ProjectModalSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _slide, child: widget.child);
  }
}

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView>
    with SingleTickerProviderStateMixin {
  late final PortfolioViewModel _viewModel;
  late final AnimationController _appFadeController;
  late final Animation<double> _appFade;

  @override
  void initState() {
    super.initState();
    _viewModel = PortfolioViewModel()..initialize();
    _appFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _appFade = CurvedAnimation(
      parent: _appFadeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _appFadeController.dispose();
    super.dispose();
  }

  void _onSplashComplete() {
    _viewModel.onSplashComplete();
    _appFadeController.forward();
  }

  void _showToast(String message) {
    ToastOverlay.show(context, message);
  }

  Future<void> _handleAction(String type) async {
    HapticFeedback.lightImpact();
    final message = await _viewModel.handleAction(type);
    if (message != null && mounted) _showToast(message);
  }

  void _showCvOptions() {
    HapticFeedback.lightImpact();
    CvOptionsSheet.show(
      context,
      onDownload: () async {
        final message = await _viewModel.downloadCv();
        if (message != null && mounted) _showToast(message);
      },
      onView: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ResumeViewerScreen(),
          ),
        );
      },
    );
  }

  Future<void> _handleShare() async {
    HapticFeedback.lightImpact();
    final error = await _viewModel.sharePortfolio();
    if (error != null && mounted) _showToast(error);
  }

  void _switchTab(PortfolioTab tab) {
    HapticFeedback.lightImpact();
    _viewModel.switchTab(tab);
  }

  void _openProjectModal(Project project) {
    HapticFeedback.lightImpact();
    _viewModel.openProjectModal(project);
  }

  void _toggleLike() {
    HapticFeedback.lightImpact();
    final liked = _viewModel.toggleLike();
    if (liked) _showToast('You liked this portfolio!');
  }

  Widget _buildTabContent(PortfolioUiContent state) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: offsetAnimation, child: child),
        );
      },
      child: KeyedSubtree(
        key: ValueKey(state.currentTab),
        child: switch (state.currentTab) {
          PortfolioTab.home => HomeTab(
              data: state.data,
              likesCount: state.likesCount,
              onWorkTap: () => _switchTab(PortfolioTab.projects),
              onCvTap: _showCvOptions,
              onViewAllSkills: () => _switchTab(PortfolioTab.profile),
            ),
          PortfolioTab.projects => ProjectsTab(
              data: state.data,
              onProjectTap: _openProjectModal,
            ),
          PortfolioTab.experience => ExperienceTab(data: state.data),
          PortfolioTab.profile => ProfileTab(
              data: state.data,
              isLiked: state.isLiked,
              onCvTap: _showCvOptions,
              onEmailTap: () => _handleAction('email'),
              onLinkedInTap: () => _handleAction('linkedin'),
              onGithubTap: () => _handleAction('github'),
              onPhoneTap: () => _handleAction('phone'),
              onLikeTap: _toggleLike,
            ),
        },
      ),
    );
  }

  Widget _buildContent(PortfolioUiContent state) {
    return FadeTransition(
      opacity: _appFade,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'PORTFOLIO',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate300,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _handleShare,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: state.isSharing
                          ? const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.accentLight,
                              ),
                            )
                          : const Icon(
                              Icons.share,
                              color: AppColors.accentLight,
                              size: 18,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildTabContent(state)),
            PortfolioBottomNav(
              currentTab: state.currentTab,
              onTabSelected: _switchTab,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(PortfolioUiState uiState) {
    return switch (uiState) {
      PortfolioUiSplash(:final name) => SplashScreen(
          name: name,
          onComplete: _onSplashComplete,
        ),
      PortfolioUiLoading() => const Center(
          child: CircularProgressIndicator(color: AppColors.accentLight),
        ),
      PortfolioUiError(:final message) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: AppColors.slate400),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _viewModel.loadPortfolio,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      PortfolioUiContent(
        :final showApp,
        :final selectedProject,
      ) =>
        Stack(
          children: [
            if (showApp)
              _buildContent(
                uiState,
              ),
            if (selectedProject != null)
              Positioned.fill(
                child: _ProjectModalSlide(
                  key: ValueKey(selectedProject.title),
                  child: ProjectDetailModal(
                    project: selectedProject,
                    onClose: _viewModel.closeProjectModal,
                    onSource: () => _handleAction('github'),
                    onLiveDemo: () => _handleAction('demo'),
                  ),
                ),
              ),
          ],
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: _buildBody(_viewModel.uiState),
        );
      },
    );
  }
}
