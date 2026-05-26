import '../../models/portfolio_models.dart';
import '../widgets/portfolio_bottom_nav.dart' show PortfolioTab;
import 'async_state.dart';

sealed class PortfolioUiState {
  const PortfolioUiState();
}

final class PortfolioUiSplash extends PortfolioUiState {
  const PortfolioUiSplash({required this.name});

  final String name;
}

final class PortfolioUiLoading extends PortfolioUiState {
  const PortfolioUiLoading();
}

final class PortfolioUiError extends PortfolioUiState {
  const PortfolioUiError({required this.message});

  final String message;
}

final class PortfolioUiContent extends PortfolioUiState {
  const PortfolioUiContent({
    required this.data,
    required this.currentTab,
    required this.isLiked,
    required this.likesCount,
    required this.selectedProject,
    required this.showApp,
    required this.shareState,
  });

  final PortfolioData data;
  final PortfolioTab currentTab;
  final bool isLiked;
  final int likesCount;
  final Project? selectedProject;
  final bool showApp;
  final AsyncState<void> shareState;

  bool get isSharing => shareState is AsyncLoading<void>;
}
