import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuccessPage extends StatelessWidget {
  final bool isQris;
  final List<Map<String, dynamic>> cart;
  final int total;

  const SuccessPage({
    super.key,
    required this.isQris,
    required this.cart,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {

    final now = DateTime.now();
    final tanggal = DateFormat("dd-MM-yyyy").format(now);
    final jam = DateFormat("HH:mm:ss").format(now);

    int subtotal = (total / 1.1).toInt();
    int ppn = total - subtotal;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Text(
              "Pembayaran Berhasil !",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),

            const SizedBox(height: 20),

            const Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Color(0xFF1E3A8A),
            ),

            const SizedBox(height: 10),

            const Text(
              "Pesananmu sedang diproses...",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // 🔷 STRUK
            Stack(
              children: [

                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Center(child: Icon(Icons.flash_on, size: 40)),

                      const SizedBox(height: 10),

                      const Center(child: Text("SAMARINDA")),
                      const Center(child: Text("Jl. Jend. Ahmad Yani")),
                      const Center(child: Text("www.gercepsignature.id")),

                      const Divider(),

                      Text("Tanggal : $tanggal"),
                      Text("Jam : $jam"),
                      const Text("Kasir : Sistem"),

                      const Divider(),

                      // 🔥 LIST ITEM DINAMIS
                      ...cart.map((item){

                        List<Widget> detail = [];

                        if(item["temp"] != null){
                          detail.add(Text("   ${item["temp"]}"));
                        }

                        if(item["addon"] != null){
                          for(var a in item["addon"].toString().split(", ")){
                            detail.add(Text("   + $a"));
                          }
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "${item["name"]} x${item["qty"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),

                            ...detail,

                            Text("Rp ${item["price"]}"),

                            const SizedBox(height: 5),
                          ],
                        );

                      }).toList(),

                      const Divider(),

                      Text("Subtotal : Rp $subtotal"),
                      Text("PPN : Rp $ppn"),
                      Text("Total : Rp $total"),

                      const Divider(),

                      Text("Metode : ${isQris ? "QRIS" : "CASH"}"),
                      const Text("Status : LUNAS"),

                      const SizedBox(height: 10),

                      const Center(child: Text("Terima Kasih")),
                      const Center(child: Text("Selamat Datang Kembali")),
                    ],
                  ),
                ),

                // 🔥 WATERMARK QRIS
                if(isQris)
                  Positioned.fill(
                    child: Center(
                      child: Transform.rotate(
                        angle: -0.5,
                        child: const Text(
                          "SUCCESS",
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFACC15),
                      ),
                      onPressed: (){
                        Navigator.popUntil(context, (r)=>r.isFirst);
                      },
                      child: const Text(
                        "Ke Menu",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF1E3A8A)),
                      ),
                      onPressed: (){},
                      icon: const Icon(Icons.download, color: Color(0xFF1E3A8A)),
                      label: const Text(
                        "Simpan Struk",
                        style: TextStyle(color: Color(0xFF1E3A8A)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}