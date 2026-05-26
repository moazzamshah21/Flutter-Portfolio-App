import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class CvService {
  const CvService();

  static const assetPath = 'assets/cv/moazzam_shah_khan_resume.pdf';
  static const fileName = 'Moazzam_Shah_Khan_Resume.pdf';

  Future<File> copyCvToTemp() async {
    final bytes = await rootBundle.load(assetPath);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
    );
    return file;
  }
}
