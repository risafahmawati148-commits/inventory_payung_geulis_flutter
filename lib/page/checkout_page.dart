import 'package:flutter/material.dart';

import '../model/cart_data.dart';
import '../service/pesanan_service.dart';

class CheckoutPage extends StatefulWidget {
  final int total;

  const CheckoutPage({
    super.key,
    required this.total,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  static const Color primaryColor = Color(0xFFFFB6A3);
  static const Color textColor = Color(0xFF5C4033);

  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final nohpController = TextEditingController();

  String metodePembayaran = "COD";

  bool loading = false;

  Future<void> buatPesanan() async {
    if (namaController.text.isEmpty ||
        alamatController.text.isEmpty ||
        nohpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Lengkapi data terlebih dahulu",
          ),
        ),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    String namaProduk = "";

    int jumlah = 0;

    for (var item in CartData.items) {
      namaProduk += "${item.namaProduk}, ";
      jumlah += item.qty;
    }

    bool berhasil = await PesananService.checkout(
      namaCustomer: namaController.text,
      produk: namaProduk,
      jumlah: jumlah,
      totalHarga: widget.total,
      alamat: alamatController.text,
    );

    setState(() {
      loading = false;
    });

    if (berhasil) {
      CartData.items.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Pesanan berhasil dibuat",
          ),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Checkout gagal",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nama Penerima",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Nomor HP",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nohpController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Alamat",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: alamatController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Total Belanja : Rp ${widget.total}",
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(
                    double.infinity,
                    55,
                  ),
                ),
                onPressed: loading
                    ? null
                    : () {
                        buatPesanan();
                      },
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Buat Pesanan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
