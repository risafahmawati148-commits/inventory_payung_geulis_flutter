import 'package:flutter/material.dart';
import '../config/api.dart';
import '../model/cart_data.dart';
import '../model/cart_model.dart';

class DetailProdukPage extends StatefulWidget {
  final int id;
  final String namaProduk;
  final String gambar;
  final String deskripsi;
  final int harga;

  const DetailProdukPage({
    super.key,
    required this.id,
    required this.namaProduk,
    required this.gambar,
    required this.deskripsi,
    required this.harga,
  });

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  static const Color primaryColor = Color(0xFF6B1A2A);
  static const Color textColor = Color(0xFF3D0C14);
  static const Color subtleText = Color(0xFF8B5E6B);

  int qty = 1;

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

  @override
  Widget build(BuildContext context) {
    int total = widget.harga * qty;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: textColor,
        title: const Text(
          "Detail Produk",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// GAMBAR PRODUK
            Container(
              height: 320,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A6B1A2A),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                child: Image.network(
                  getFullImageUrl(widget.gambar),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_rounded,
                        size: 80,
                        color: primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// NAMA PRODUK
                  Text(
                    widget.namaProduk,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// RATING
                  const Row(
                    children: [
                      Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                      Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                      Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                      Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                      Icon(Icons.star_half_rounded, color: Colors.amber, size: 22),
                      SizedBox(width: 6),
                      Text(
                        "(4.5)",
                        style: TextStyle(
                          color: subtleText,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// HARGA
                  Text(
                    _formatRupiah(widget.harga),
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Divider(height: 40, color: Color(0xFFD4A0A8), thickness: 1.5),

                  /// DESKRIPSI
                  const Text(
                    "Deskripsi Produk",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.deskripsi,
                    style: const TextStyle(
                      color: subtleText,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),

                  const Divider(height: 40, color: Color(0xFFD4A0A8), thickness: 1.5),

                  /// JUMLAH
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Jumlah",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBF0),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: const Color(0xFFD4A0A8),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (qty > 1) {
                                  setState(() {
                                    qty--;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.remove_rounded,
                                color: primaryColor,
                                size: 22,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                qty.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  qty++;
                                });
                              },
                              icon: const Icon(
                                Icons.add_rounded,
                                color: primaryColor,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// TOTAL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Harga",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: subtleText,
                        ),
                      ),
                       Text(
                        _formatRupiah(total),
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// TAMBAH KERANJANG
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        CartData.items.add(
                          CartModel(
                            id: widget.id,
                            namaProduk: widget.namaProduk,
                            gambar: widget.gambar,
                            deskripsi: widget.deskripsi,
                            harga: widget.harga,
                            qty: qty,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: primaryColor,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            content: Text(
                              "${widget.namaProduk} berhasil ditambahkan ke keranjang",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart_rounded,
                      ),
                      label: const Text(
                        "Tambah Keranjang",
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// BELI SEKARANG
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        CartData.items.add(
                          CartModel(
                            id: widget.id,
                            namaProduk: widget.namaProduk,
                            gambar: widget.gambar,
                            deskripsi: widget.deskripsi,
                            harga: widget.harga,
                            qty: qty,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: primaryColor,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            content: const Text(
                              "Melanjutkan ke Keranjang Saya",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ),
                        );
                        // Navigate to Keranjang or pop to main and switch to cart tab
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Beli Sekarang",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
