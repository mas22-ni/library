import 'package:flutter/material.dart';
import 'splash.dart';

// 🔥 GLOBAL VARIABLE
String mejaGlobal = "";

void main() {

  // 🔥 AMBIL PARAMETER (AMAN UNTUK WEB)
  try {
    final uri = Uri.base;
    mejaGlobal = uri.queryParameters['meja'] ?? "";
  } catch (e) {
    mejaGlobal = "";
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}