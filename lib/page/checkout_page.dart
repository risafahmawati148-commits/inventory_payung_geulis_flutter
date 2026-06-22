import 'package:flutter/material.dart';

import '../model/cart_data.dart';
import '../model/user_model.dart';
import '../service/pesanan_service.dart';
import 'dashboard_page.dart';

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
  static const Color primaryColor = Color(0xFF6B1A2A);
  static const Color textColor = Color(0xFF3D0C14);
  static const Color subtleText = Color(0xFF8B5E6B);

  late final TextEditingController namaController;
  final alamatController = TextEditingController();
  final nohpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: UserModel.currentUser?.nama ?? "");
  }

  @override
  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    nohpController.dispose();
    super.dispose();
  }

  String metodePembayaran = "COD";

  bool loading = false;

  String _formatRupiah(int number) {
    final str = number.toString();
    String result = '';
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      result = str[i] + result;
      count++;
      if (count % 3 == 0 && i != 0) {
        result = '.' + result;
      }
    }
    return 'Rp $result';
  }

  Future<void> buatPesanan() async {
    if (namaController.text.isEmpty ||
        alamatController.text.isEmpty ||
        nohpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: const Text(
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
      email: UserModel.currentUser?.email ?? "",
    );

    setState(() {
      loading = false;
    });

    if (berhasil) {
      CartData.items.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: const Text(
            "Pesanan berhasil dibuat",
          ),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardPage(initialIndex: 0),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: const Text(
            "Checkout gagal",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                hintText: "Masukkan nama penerima...",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Nomor HP",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nohpController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Masukkan nomor HP...",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Alamat Lengkap",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: alamatController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Masukkan alamat lengkap...",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: subtleText,
                  ),
                ),
                 Text(
                  _formatRupiah(widget.total),
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : () {
                        buatPesanan();
                      },
                child: loading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text(
                        "Buat Pesanan",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
