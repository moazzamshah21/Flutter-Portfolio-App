import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ProjectImage extends StatelessWidget {
  const ProjectImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final BoxFit fit;

  /// Use for projects that should show the built-in Flutter logo.
  static const flutterLogoKey = 'flutter-logo';

  static bool isAsset(String url) => url.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    if (imageUrl == flutterLogoKey) {
      return ColoredBox(
        color: AppColors.slate800,
        child: Center(
          child: const FlutterLogo(
            size: 88,
            style: FlutterLogoStyle.markOnly,
          ),
        ),
      );
    }
    if (isAsset(imageUrl)) {
      return Image.asset(
        imageUrl,
        fit: fit,
        errorBuilder: _errorBuilder,
      );
    }
    return Image.network(
      imageUrl,
      fit: fit,
      errorBuilder: _errorBuilder,
    );
  }

  static Widget _errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Container(
      color: AppColors.slate800,
      child: const Icon(Icons.image, color: AppColors.slate500),
    );
  }
}
