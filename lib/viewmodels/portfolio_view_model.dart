import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/state/async_state.dart';
import '../core/state/portfolio_ui_state.dart';
import '../core/widgets/portfolio_bottom_nav.dart';
import '../data/repositories/portfolio_repository.dart';
import '../data/services/cv_service.dart';
import '../models/portfolio_models.dart';

class PortfolioViewModel extends ChangeNotifier {
  PortfolioViewModel({
    PortfolioRepository? repository,
    CvService? cvService,
  })  : _repository = repository ?? const PortfolioRepository(),
        _cvService = cvService ?? const CvService();

  final PortfolioRepository _repository;
  final CvService _cvService;

  AsyncState<PortfolioData> _portfolioState = const AsyncInitial();
  AsyncState<void> _shareState = const AsyncInitial();
  bool _showSplash = true;
  bool _showApp = false;
  PortfolioTab _currentTab = PortfolioTab.home;
  bool _isLiked = false;
  int _likesCount = 42;
  Project? _selectedProject;

  PortfolioUiState get uiState {
    if (_showSplash) {
      final name = switch (_portfolioState) {
        AsyncSuccess(:final data) => data.name,
        _ => 'Portfolio',
      };
      return PortfolioUiSplash(name: name);
    }

    return switch (_portfolioState) {
      AsyncInitial() || AsyncLoading() => const PortfolioUiLoading(),
      AsyncError(:final message) => PortfolioUiError(message: message),
      AsyncSuccess(:final data) => PortfolioUiContent(
          data: data,
          currentTab: _currentTab,
          isLiked: _isLiked,
          likesCount: _likesCount,
          selectedProject: _selectedProject,
          showApp: _showApp,
          shareState: _shareState,
        ),
    };
  }

  Future<void> initialize() async {
    await loadPortfolio();
  }

  Future<void> loadPortfolio() async {
    _portfolioState = const AsyncLoading();
    notifyListeners();

    try {
      final data = await _repository.fetchPortfolio();
      _portfolioState = AsyncSuccess(data);
    } catch (e) {
      _portfolioState = AsyncError(e.toString(), cause: e);
    }
    notifyListeners();
  }

  void onSplashComplete() {
    _showSplash = false;
    _showApp = true;
    notifyListeners();
  }

  void switchTab(PortfolioTab tab) {
    if (_currentTab == tab) return;
    _currentTab = tab;
    notifyListeners();
  }

  void openProjectModal(Project project) {
    _selectedProject = project;
    notifyListeners();
  }

  void closeProjectModal() {
    _selectedProject = null;
    notifyListeners();
  }

  bool toggleLike() {
    _isLiked = !_isLiked;
    _likesCount += _isLiked ? 1 : -1;
    notifyListeners();
    return _isLiked;
  }

  Future<String?> handleAction(String type) async {
    final data = switch (_portfolioState) {
      AsyncSuccess(:final data) => data,
      _ => null,
    };
    if (data == null) return null;

    switch (type) {
      case 'email':
        return _launchEmail(data.email);
      case 'linkedin':
        return _launchWebUrl(data.linkedInUrl, 'LinkedIn');
      case 'github':
        return _launchWebUrl(data.githubUrl, 'GitHub');
      case 'phone':
        return _launchPhone(data.phone);
      case 'demo':
        return 'Launching live demo application...';
      default:
        return null;
    }
  }

  Future<String?> downloadCv() async {
    try {
      final file = await _cvService.copyCvToTemp();
      await Share.shareXFiles(
        [XFile(file.path, name: CvService.fileName)],
        subject: 'Moazzam Shah Khan — Resume',
        text: 'Resume — Moazzam Shah Khan',
      );
      return 'Resume ready to save or share.';
    } catch (e) {
      return 'Could not share resume: $e';
    }
  }

  Future<String?> _launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    final ok = await _launchUri(uri);
    return ok ? null : 'Could not open email app.';
  }

  Future<String?> _launchPhone(String phone) async {
    final normalized = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri(scheme: 'tel', path: normalized);
    final ok = await _launchUri(uri);
    return ok ? null : 'Could not open phone dialer.';
  }

  Future<String?> _launchWebUrl(String url, String label) async {
    final uri = Uri.parse(url);
    final ok = await _launchUri(uri);
    return ok ? null : 'Could not open $label.';
  }

  Future<bool> _launchUri(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  Future<String?> sharePortfolio() async {
    if (_shareState is AsyncLoading<void>) return null;

    _shareState = const AsyncLoading();
    notifyListeners();

    try {
      if (_currentTab != PortfolioTab.home) {
        _currentTab = PortfolioTab.home;
        notifyListeners();
        await Future<void>.delayed(const Duration(milliseconds: 400));
      }

      final data = switch (_portfolioState) {
        AsyncSuccess(:final data) => data,
        _ => throw StateError('Portfolio not loaded'),
      };

      await Share.share(
        "Check out ${data.name}'s Developer Portfolio!\n\n${data.role}\n${data.bio}",
        subject: "${data.name}'s Developer Portfolio",
      );
      _shareState = const AsyncInitial();
      notifyListeners();
      return null;
    } catch (e) {
      _shareState = AsyncError(e.toString(), cause: e);
      notifyListeners();
      return 'Failed to share.';
    }
  }
}
