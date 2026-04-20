import 'package:flutter/material.dart';
import 'data.dart';
import 'pesanan_page.dart';

class MenuPage extends StatefulWidget {
  final String nama;
  final String meja; // 🔥 TAMBAHAN

  const MenuPage({
    super.key,
    required this.nama,
    required this.meja,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  String kategori = "Coffee";
  String subKategori = "Classic";
  List<Map<String, dynamic>> cart = [];

  void add(item){
    int i = cart.indexWhere((e)=>e["name"]==item["name"]);
    if(i!=-1){
      cart[i]["qty"]++;
    }else{
      cart.add({...item,"qty":1});
    }
  }

  int getQty(String name){
    int i = cart.indexWhere((e)=>e["name"]==name);
    return i==-1 ? 0 : cart[i]["qty"];
  }

  @override
  Widget build(BuildContext context) {

    var data = menuData.where((e){

      if(e["category"] != kategori) return false;

      if(kategori == "Coffee" || kategori == "Non-Coffee"){
        return e["sub"] == subKategori;
      }

      return true;

    }).toList();

    int total = cart.fold(0,(s,e)=>s+(e["price"]*e["qty"] as int));

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: Column(
          children: [

            // 🔷 HEADER (TIDAK DIUBAH)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 20)
                  ],
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    // 🔥 FIX DI SINI (AMBIL DARI QR)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Meja ${widget.meja}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // 🔷 SISANYA TETAP (TIDAK DIUBAH SAMA SEKALI)
            const Text(
              "MENU",
              style: TextStyle(
                color: Color(0xFF1E3A8A),
                fontSize: 35,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Selamat datang! Silahkan pilih menu favoritmu.",
              style: TextStyle(color: Colors.orange),
            ),

            const SizedBox(height: 10),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["Coffee","Non-Coffee","Foods","Snack"].map((c){

                  bool aktif = kategori == c;

                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        kategori = c;

                        if(kategori == "Coffee"){
                          subKategori = "Classic";
                        }else if(kategori == "Non-Coffee"){
                          subKategori = "Non-Coffee";
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: aktif ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        c,
                        style: TextStyle(
                          color: aktif ? const Color(0xFF1E3A8A) : Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  );

                }).toList(),
              ),
            ),

            if(kategori == "Coffee" || kategori == "Non-Coffee")
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (kategori == "Coffee"
                      ? ["Classic", "Signature"]
                      : ["Non-Coffee", "Matcha"]
                  ).map((sub){

                    bool aktif = subKategori == sub;

                    return GestureDetector(
                      onTap: ()=>setState(()=>subKategori = sub),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: aktif ? const Color(0xFF1E3A8A) : Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          sub,
                          style: TextStyle(
                            color: aktif ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );

                  }).toList(),
                ),
              ),

            const SizedBox(height: 10),

            Expanded(
              child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (_,i){

                  var item = data[i];
                  int qty = getQty(item["name"]);

                  return GestureDetector(
                    onTap: (){
                      setState(()=>add(item));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: qty>0 ? const Color(0xFF1E3A8A) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          const Icon(Icons.local_cafe, size: 40),

                          const SizedBox(height: 5),

                          Text(
                            item["name"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: qty>0 ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Rp ${item["price"]}",
                            style: TextStyle(
                              color: qty>0 ? Colors.white : Colors.black,
                            ),
                          ),

                          if(qty>0)
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Text("$qty"),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if(cart.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFACC15),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PesananPage(
                          cart: cart,
                          nama: widget.nama,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Lanjut (${cart.length}) | Rp $total",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}