import 'package:flutter/material.dart';
import 'success_page.dart';

class QrisPage extends StatefulWidget {
  final int total;
  final List<Map<String, dynamic>> cart;

  const QrisPage({
    super.key,
    required this.total,
    required this.cart,
  });

  @override
  State<QrisPage> createState() => _QrisPageState();
}

class _QrisPageState extends State<QrisPage> {

  @override
  void initState() {
    super.initState();

    // 🔥 AUTO PINDAH KE SUCCESS (TANPA UBAH UI)
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SuccessPage(
            isQris: true,
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

            // 🔥 BACKGROUND LOGO (SAMAR)
            Positioned.fill(
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  "assets/logo.jpeg",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Column(
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
                  "Scan QRIS",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔷 QR BOX
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.qr_code, size: 130),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Pindai kode QR untuk menyelesaikan pembayaran",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Total Bayar : Rp ${widget.total}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // 🔥 BUTTON SIMPAN (TETAP ADA, TIDAK DIUBAH)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF1E3A8A),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                      onPressed: (){},
                      icon: const Icon(
                        Icons.download,
                        color: Color(0xFF1E3A8A),
                      ),
                      label: const Text(
                        "Simpan Kode QR",
                        style: TextStyle(
                          color: Color(0xFF1E3A8A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}