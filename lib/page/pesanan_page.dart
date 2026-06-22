import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../service/pesanan_service.dart';

// ─────────────────────────────────────────────
//  Dashed Line Divider Widget
// ─────────────────────────────────────────────
class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  const DashedDivider({super.key, this.height = 1.2, this.color = const Color(0xFFD4A0A8)});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        const dashGap = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashGap)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  static const Color primaryColor = Color(0xFF6B1A2A);
  static const Color textColor = Color(0xFF3D0C14);
  // Gelapkan warna subtleText agar terbaca dengan jelas (Opacity 70% marun)
  static final Color subtleText = const Color(0xFF6B1A2A).withOpacity(0.70);

  List pesanan = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getPesanan();
  }

  Future<void> getPesanan() async {
    final email = UserModel.currentUser?.email ?? "";
    final data = await PesananService.getPesanan(email: email);

    setState(() {
      pesanan = data;
      loading = false;
    });
  }

  // Helper formatting Rupiah agar rapi dengan titik pemisah ribuan
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

  Widget statusBadge(String status) {
    Color bgColor;
    Color txtColor;

    switch (status) {
      case "Diproses":
        bgColor = const Color(0xFFFAF0E6);
        txtColor = const Color(0xFF8A5D3B);
        break;
      case "Dikirim":
        bgColor = const Color(0xFFE6F2FF);
        txtColor = const Color(0xFF2B5B84);
        break;
      case "Selesai":
        bgColor = const Color(0xFFE2F3E5);
        txtColor = const Color(0xFF2E6F40);
        break;
      default:
        // Status Pending / Menunggu Pembayaran
        bgColor = const Color(0xFFFFECEC);
        txtColor = const Color(0xFF8A2E2E);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: txtColor,
          fontWeight: FontWeight.bold,
          fontSize: 11,
          height: 1.1, // Balance text vertically inside badge
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            )
          : pesanan.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.inventory_2_outlined,
                        size: 80,
                        color: primaryColor,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Belum ada pesanan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: getPesanan,
                  child: ListView.builder(
                    itemCount: pesanan.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    itemBuilder: (context, index) {
                      final item = pesanan[index];
                      final int parsedHarga = item["total_harga"] is int 
                          ? item["total_harga"] 
                          : int.tryParse(item["total_harga"].toString()) ?? 0;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Pertegas nama produk (Bold & lebih besar)
                                  Expanded(
                                    child: Text(
                                      item["produk"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  statusBadge(item["status"]),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Custom Dashed Divider yang Dinamis
                              const DashedDivider(
                                height: 1.2,
                                color: Color(0xFFD4A0A8),
                              ),
                              const SizedBox(height: 12),
                              // Detail Info dengan kontras tinggi (lebih gelap) dan ikon lebih besar
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline_rounded,
                                    size: 19,
                                    color: subtleText,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Customer : ${item["nama_customer"]}",
                                    style: TextStyle(
                                      color: subtleText,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 19,
                                    color: subtleText,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Jumlah : ${item["jumlah"]} item",
                                    style: TextStyle(
                                      color: subtleText,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 19,
                                    color: subtleText,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Alamat : ${item["alamat"]}",
                                      style: TextStyle(
                                        color: subtleText,
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const DashedDivider(
                                height: 1.2,
                                color: Color(0xFFD4A0A8),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Harga",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: subtleText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Format Rupiah ribuan (contoh: Rp 120.000)
                                  Text(
                                    _formatRupiah(parsedHarga),
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
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
