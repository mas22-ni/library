import 'package:flutter/material.dart';
import 'menu_page.dart';

class InputNamaPage extends StatefulWidget {

  final String meja; // 🔥 TAMBAHAN

  const InputNamaPage({
    super.key,
    required this.meja,
  });

  @override
  State<InputNamaPage> createState() => _InputNamaPageState();
}

class _InputNamaPageState extends State<InputNamaPage> {

  final TextEditingController nama = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset("assets/logo.jpeg", height: 100),

              const SizedBox(height: 10),

              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFFFACC15),
                    Color(0xFF1E3A8A),
                  ],
                ).createShader(bounds),
                child: const Text(
                  "Gercep Signature.id",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 🔥 TAMBAHAN (TIDAK MENGUBAH TAMPILAN BESAR)
             
              const SizedBox(height: 20),

              TextField(
                controller: nama,
                decoration: InputDecoration(
                  hintText: "Masukkan Nama",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFACC15),
                ),
                onPressed: (){
                  if(nama.text.isEmpty) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MenuPage(
                        nama: nama.text,
                        meja: widget.meja, // 🔥 KIRIM MEJA
                      ),
                    ),
                  );
                },
                child: const Text(
                  "PESAN",
                  style: TextStyle(
                    color: Color(0xFF1E3A8A),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}