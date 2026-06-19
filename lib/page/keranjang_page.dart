import 'package:flutter/material.dart';

import '../config/api.dart';
import '../model/cart_data.dart';
import 'checkout_page.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  static const Color primaryColor = Color(0xFF6B1A2A);
  static const Color textColor = Color(0xFF3D0C14);
  static const Color subtleText = Color(0xFF8B5E6B);

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

  int get totalBelanja {
    int total = 0;

    for (var item in CartData.items) {
      total += item.harga * item.qty;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Keranjang Saya",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CartData.items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: primaryColor,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Keranjang masih kosong",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: CartData.items.length,
                    itemBuilder: (context, index) {
                      final item = CartData.items[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  getFullImageUrl(item.gambar),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 80,
                                      height: 80,
                                      color: const Color(0xFFFFFBF0),
                                      child: const Icon(
                                        Icons.image_rounded,
                                        size: 30,
                                        color: primaryColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.namaProduk,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _formatRupiah(item.harga),
                                      style: const TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFBF0),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color(0xFFD4A0A8),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (item.qty > 1) {
                                                  item.qty--;
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.remove_rounded,
                                              color: primaryColor,
                                              size: 18,
                                            ),
                                            constraints: const BoxConstraints(),
                                            padding: const EdgeInsets.all(6),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              item.qty.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                item.qty++;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.add_rounded,
                                              color: primaryColor,
                                              size: 18,
                                            ),
                                            constraints: const BoxConstraints(),
                                            padding: const EdgeInsets.all(6),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    CartData.items.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Color(0xFFE57373),
                                  size: 26,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    border: const Border(
                      top: BorderSide(
                        color: Color(0xFFD4A0A8),
                        width: 1.5,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B1A2A).withOpacity(0.06),
                        blurRadius: 15,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Belanja",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: subtleText,
                            ),
                          ),
                          Text(
                            _formatRupiah(totalBelanja),
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (CartData.items.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: primaryColor,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  content: const Text(
                                    "Keranjang masih kosong",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                ),
                              );

                              return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutPage(
                                  total: totalBelanja,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Checkout",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
