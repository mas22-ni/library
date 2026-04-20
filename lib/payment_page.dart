import 'package:flutter/material.dart';
import 'qris_page.dart';
import 'cash_page.dart';

class PaymentPage extends StatefulWidget {
  final int total;
  final String nama;
  final List<Map<String, dynamic>> cart;

  const PaymentPage({
    super.key,
    required this.total,
    required this.nama,
    required this.cart,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  String metode = "Cash";

  @override
  Widget build(BuildContext context) {

    int ppn = (widget.total * 0.1).toInt();
    int grand = widget.total + ppn;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: Column(
          children: [

            // 🔥 HEADER ATAS
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [

                    Image.asset("assets/logo.jpeg", width: 40),

                    const SizedBox(width: 10),

                    Text(
                      "Halo, ${widget.nama}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Meja 01",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // 🔷 HEADER
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [ 
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ), 
                  
                  Expanded( 
                    child: Center( 
                      child: const Text( 
                        "Pembayaran", 
                        style: TextStyle( 
                          fontSize: 20,
                          fontWeight: FontWeight.bold, 
                          color: Color(0xFF1E3A8A), 
                        ), 
                      ),
                    ), 
                  ),

                  const SizedBox(width: 48),
                ],
              ),
            ),

            // 🔷 METODE
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _metodeItem("Cash", Icons.payments),
                  _metodeItem("QRIS", Icons.qr_code),
                ],
              ),
            ),

            // 🔷 RINGKASAN
            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (_, i){

                  var item = widget.cart[i];

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "${item["name"]} x${item["qty"]}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        if(item["temp"] != null && item["temp"] != "")
                          Text("☕ ${item["temp"]}", style: const TextStyle(fontSize: 12)),

                        if(item["addon"] != null && item["addon"] != "")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: item["addon"]
                                .toString()
                                .split(", ")
                                .map<Widget>((a){
                                  return Text("+ $a", style: const TextStyle(fontSize: 12));
                                }).toList(),
                          ),

                        const SizedBox(height: 5),

                        Text("Rp ${item["price"]}"),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔷 TOTAL
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [

                  Row(
                    children: [
                      const Text("Subtotal"),
                      const Spacer(),
                      Text("Rp ${widget.total}"),
                    ],
                  ),

                  Row(
                    children: [
                      const Text("PPN (10%)"),
                      const Spacer(),
                      Text("Rp $ppn"),
                    ],
                  ),

                  const Divider(),

                  Row(
                    children: [
                      const Text(
                        "Total Bayar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        "Rp $grand",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFACC15),
                      ),
                      onPressed: (){

                        if(metode == "QRIS"){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QrisPage(
                                total: grand,
                                cart: widget.cart,
                              ),
                            ),
                          );
                        }else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CashPage(
                                total: grand,
                                cart: widget.cart,
                              ),
                            ),
                          );
                        }

                      },
                      child: const Text(
                        "Bayar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 🔷 METODE ITEM
  Widget _metodeItem(String namaMetode, IconData icon){
    bool aktif = metode == namaMetode;

    return GestureDetector(
      onTap: ()=>setState(()=>metode = namaMetode),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: aktif ? const Color(0xFF1E3A8A) : Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          children: [

            Icon(icon, color: const Color(0xFF1E3A8A)),

            const SizedBox(width: 10),

            Text(
              namaMetode,
              style: const TextStyle(
                color: Color(0xFF1E3A8A),
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF1E3A8A),
                  width: 2,
                ),
                color: aktif ? const Color(0xFF1E3A8A) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}