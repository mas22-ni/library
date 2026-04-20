import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url); // 🔥 FIX

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Tidak bisa buka link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR")),
      body: MobileScanner(
        onDetect: (barcode) {
          final String? code = barcode.barcodes.first.rawValue;

          if (code != null) {
            openLink(code); // 🔥 buka link dari QR
          }
        },
      ),
    );
  }
}