import 'package:flutter/material.dart';

import '../service/pesanan_service.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  static const Color primaryColor = Color(0xFFFFB6A3);
  static const Color textColor = Color(0xFF5C4033);

  List pesanan = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getPesanan();
  }

  Future<void> getPesanan() async {
    final data = await PesananService.getPesanan();

    setState(() {
      pesanan = data;
      loading = false;
    });
  }

  Color warnaStatus(String status) {
    switch (status) {
      case "Diproses":
        return Colors.orange;

      case "Dikirim":
        return Colors.blue;

      case "Selesai":
        return Colors.green;

      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Pesanan Saya",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pesanan.isEmpty
              ? const Center(
                  child: Text(
                    "Belum ada pesanan",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: getPesanan,
                  child: ListView.builder(
                    itemCount: pesanan.length,
                    itemBuilder: (context, index) {
                      final item = pesanan[index];

                      return Card(
                        margin: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["produk"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Nama Customer : ${item["nama_customer"]}",
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Jumlah : ${item["jumlah"]}",
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Alamat : ${item["alamat"]}",
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Rp ${item["total_harga"]}",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: warnaStatus(
                                    item["status"],
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: Text(
                                  item["status"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
