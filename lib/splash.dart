import 'package:flutter/material.dart';
import 'input_nama.dart';
import 'main.dart'; // kalau masih pakai mejaGlobal untuk halaman berikutnya

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => InputNamaPage(
            meja: mejaGlobal, // dikirim diam-diam, tidak ditampilkan di splash
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/logo.jpeg",
          height: 120,
        ),
      ),
    );
  }
}