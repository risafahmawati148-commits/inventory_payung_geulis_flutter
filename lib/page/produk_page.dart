import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_produk_page.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  List produk = [];
  bool loading = true;

  final String baseUrl = "http://192.168.20.28:8000";

  static const Color primaryColor = Color(0xFF6B1A2A);
  static const Color textColor = Color(0xFF3D0C14);
  static const Color subtleText = Color(0xFF8B5E6B);
  static const Color gold = Color(0xFFB8860B);

  @override
  void initState() {
    super.initState();
    fetchProduk();
  }

  Future<void> fetchProduk() async {
    try {
      final response = await http.get(
        Uri.parse(
          "$baseUrl/api/produk-customer",
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          produk = data["data"];
          loading = false;
        });

        for (var item in produk) {
          print(item["gambar"]);
        }
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });

      print("ERROR API : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFFAF3E0),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: textColor,
        title: const Text(
          "Produk Payung Geulis",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: produk.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, index) {
          final item = produk[index];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFD4A0A8),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailProdukPage(
                            id: item["id"] ?? 0,
                            namaProduk: item["nama_produk"] ?? "",
                            deskripsi: item["deskripsi"] ?? "",
                            harga: item["harga"] ?? 0,
                            gambar: item["gambar"] ?? "",
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.network(
                        item["gambar"] ?? "",
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (
                          context,
                          child,
                          loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          print(
                            "ERROR GAMBAR : ${item["gambar"]}",
                          );

                          return Container(
                            color: const Color(0xFFFFFBF0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.broken_image,
                                  color: primaryColor,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Gambar tidak ditemukan",
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["nama_produk"] ?? "-",
                        style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Rp ${item["harga"]}",
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Beli",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
