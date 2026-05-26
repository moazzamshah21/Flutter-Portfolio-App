import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfx/pdfx.dart';

import '../core/theme/app_colors.dart';
import '../data/services/cv_service.dart';

class ResumeViewerScreen extends StatefulWidget {
  const ResumeViewerScreen({super.key});

  @override
  State<ResumeViewerScreen> createState() => _ResumeViewerScreenState();
}

class _ResumeViewerScreenState extends State<ResumeViewerScreen> {
  late final PdfControllerPinch _controller;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = PdfControllerPinch(
      document: PdfDocument.openAsset(CvService.assetPath),
    );
    _controller.loadingState.addListener(_onLoadingChanged);
  }

  void _onLoadingChanged() {
    if (!mounted) return;
    setState(() {
      _loading = _controller.loadingState.value == PdfLoadingState.loading;
      _error = _controller.loadingState.value == PdfLoadingState.error
          ? 'Could not load resume.'
          : null;
    });
  }

  @override
  void dispose() {
    _controller.loadingState.removeListener(_onLoadingChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Full Resume',
          style: GoogleFonts.inter(
            color: AppColors.textMain,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _error != null
          ? Center(
              child: Text(
                _error!,
                style: GoogleFonts.inter(color: AppColors.slate400),
              ),
            )
          : Stack(
              children: [
                PdfViewPinch(
                  controller: _controller,
                  padding: 10,
                  backgroundDecoration: const BoxDecoration(
                    color: AppColors.bg,
                  ),
                ),
                if (_loading)
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentLight,
                    ),
                  ),
              ],
            ),
    );
  }
}
