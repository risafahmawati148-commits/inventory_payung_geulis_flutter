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
  static const Color primaryColor = Color(0xFFFFB6A3);
  static const Color textColor = Color(0xFF5C4033);

  int qty = 1;

  @override
  Widget build(BuildContext context) {
    int total = widget.harga * qty;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              color: Colors.white,
              child: Image.network(
                getFullImageUrl(widget.gambar),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.image,
                      size: 100,
                      color: Colors.grey,
                    ),
                  );
                },
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

                  const SizedBox(height: 10),

                  /// RATING
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star_half, color: Colors.amber),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// HARGA
                  Text(
                    "Rp ${widget.harga}",
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// DESKRIPSI
                  const Text(
                    "Deskripsi Produk",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.deskripsi,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// JUMLAH
                  const Text(
                    "Jumlah",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
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
                          Icons.remove_circle,
                          color: primaryColor,
                          size: 35,
                        ),
                      ),
                      Text(
                        qty.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            qty++;
                          });
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: primaryColor,
                          size: 35,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// TOTAL
                  Text(
                    "Total : Rp $total",
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// TAMBAH KERANJANG
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(
                          double.infinity,
                          55,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
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
                            content: Text(
                              "${widget.namaProduk} berhasil ditambahkan ke keranjang",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                      ),
                      label: const Text(
                        "Tambah Keranjang",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// BELI SEKARANG
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(
                          double.infinity,
                          55,
                        ),
                        foregroundColor: primaryColor,
                        side: const BorderSide(
                          color: primaryColor,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Beli Sekarang",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
