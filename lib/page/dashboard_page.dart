import 'package:flutter/material.dart';

import '../model/cart_data.dart';
import 'home_page.dart';
import 'keranjang_page.dart';
import 'pesanan_page.dart';
import 'profil_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const Color primaryColor = Color(0xFFFFB6A3);

  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    KeranjangPage(),
    PesananPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 13,
          elevation: 0,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              label: "Keranjang",
              icon: Badge(
                isLabelVisible: CartData.items.isNotEmpty,
                backgroundColor: Colors.red,
                label: Text(
                  "${CartData.items.length}",
                ),
                child: const Icon(
                  Icons.shopping_cart_rounded,
                ),
              ),
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.inventory_2_rounded,
              ),
              label: "Pesanan",
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
              ),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}
