import 'package:flutter/material.dart';
import 'success_page.dart';

class CashPage extends StatefulWidget {
  final int total;
  final List<Map<String, dynamic>> cart;

  const CashPage({
    super.key,
    required this.total,
    required this.cart,
  });

  @override
  State<CashPage> createState() => _CashPageState();
}

class _CashPageState extends State<CashPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), (){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SuccessPage(
            isQris: false,
            cart: widget.cart,
            total: widget.total,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: Stack(
          children: [

            // 🔥 BACKGROUND LOGO SAMAR
            Positioned.fill(
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  "assets/logo.jpeg",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 🔥 FIX: CENTER TANPA UBAH TAMPILAN
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const SizedBox(height: 20),

                  const Text(
                    "Order ID : #Gercep-001",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Bayar di Kasir",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Icon(
                    Icons.attach_money,
                    size: 120,
                    color: Colors.black,
                  ),

                  const SizedBox(height: 30),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF1E3A8A),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [

                        const Text(
                          "Sebutkan Nomor Meja Anda",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "MEJA 01",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "✔ Data sudah terkirim ke kasir",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    "Total Bayar : Rp ${widget.total}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "-----------------------------",
                    style: TextStyle(color: Colors.black),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Silahkan menuju kasir untuk melakukan pembayaran tunai!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}