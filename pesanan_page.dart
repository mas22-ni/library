import 'package:flutter/material.dart';
import 'payment_page.dart';

class PesananPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final String nama;

  const PesananPage({
    super.key,
    required this.cart,
    required this.nama,
  });

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {

  // 🔥 DATA ADDON
  Map<String, int> addons = {
    "Extra Shot": 5000,
    "Oat Milk": 7000,
    "Almond Milk": 7000,
    "Caramel Crumble": 6000,
    "Pure Matcha": 7000,
    "Caramel Syrup": 5000,
    "Seasalt Foam": 10000,
  };

  // 🔥 POPUP BOTTOM SHEET
  void showAddonPopup(int index) {

    Map<String, bool> selected = {};
    String? selectedTemp;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {

            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // HANDLE
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // TITLE
                  Center(
                    child: Text(
                      widget.cart[index]["name"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text("Add-ons",
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  // 🔥 LIST ADDON
                  Expanded(
                    child: ListView(
                      children: addons.keys.map((name){

                        bool isChecked = selected[name] ?? false;

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              name,
                              style: const TextStyle(
                                color: Color(0xFF1E3A8A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            secondary: Text(
                              "Rp ${addons[name]}",
                              style: const TextStyle(
                                color: Color(0xFF1E3A8A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: isChecked,
                            onChanged: (v){
                              setStateDialog(() {
                                selected[name] = v!;
                              });
                            },
                          ),
                        );

                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔥 HOT / ICE
                  const Text(
                    "Hot or Ice",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [

                        RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Hot",
                            style: TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: "Hot",
                          groupValue: selectedTemp,
                          onChanged: (v){
                            setStateDialog(() {
                              selectedTemp = v;
                            });
                          },
                        ),

                        RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Ice",
                            style: TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: "Ice",
                          groupValue: selectedTemp,
                          onChanged: (v){
                            setStateDialog(() {
                              selectedTemp = v;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFACC15),
                      ),
                      onPressed: (){

                        List<String> pilih = [];

                        selected.forEach((key, value) {
                          if(value) pilih.add(key);
                        });

                        setState(() {
                          widget.cart[index]["addon"] =
                              pilih.isNotEmpty ? pilih.join(", ") : null;

                          widget.cart[index]["temp"] = selectedTemp;
                        });

                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    // 🔥 TOTAL + ADDON
    int total = widget.cart.fold(0, (s, e){

      int harga = (e["price"] ?? 0) as int;
      int qty = (e["qty"] ?? 0) as int;

      int addonHarga = 0;

      if(e["addon"] != null){
        List listAddon = e["addon"].toString().split(", ");
        for(var a in listAddon){
          addonHarga += addons[a] ?? 0;
        }
      }

      return s + ((harga + addonHarga) * qty);
    });

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: Column(
          children: [

            // HEADER
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
                    Text("Halo, ${widget.nama}",
                        style: const TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Meja 01",
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),

            const Text("Pesanan Anda",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A))),

            const SizedBox(height: 5),

            const Text(
              "Mau ubah pesanan? Silahkan cek menu lagi",
              style: TextStyle(color: Colors.orange, fontSize: 12),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (_,i){

                  var item = widget.cart[i];

                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [

                        const Icon(Icons.local_cafe, size: 40),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(item["name"]),

                              GestureDetector(
                                onTap: () => showAddonPopup(i),
                                child: const Text(
                                  "Custom Order",
                                  style: TextStyle(
                                      color: Color(0xFF1E3A8A),
                                      fontSize: 12),
                                ),
                              ),

                              if(item["addon"] != null)
                                Text("✏️ ${item["addon"]}",
                                    style: const TextStyle(fontSize: 12)),

                              if(item["temp"] != null)
                                Text("☕ ${item["temp"]}",
                                    style: const TextStyle(fontSize: 12)),

                              Text("Rp ${item["price"]}"),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: (){
                                setState(() {
                                  if(item["qty"] > 1){
                                    item["qty"]--;
                                  }else{
                                    widget.cart.removeAt(i);
                                  }
                                });
                              },
                            ),
                            Text("${item["qty"]}"),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: (){
                                setState(() {
                                  item["qty"]++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Text("Total Harga:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A))),
                  const Spacer(),
                  Text("Rp $total"),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFACC15)),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ke Menu",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A))),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFACC15)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentPage(
                            total: total,
                            nama: widget.nama,
                            cart: widget.cart,
                          ),
                        ),
                      );
                    },
                    child: const Text("Pembayaran",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}