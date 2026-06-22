import 'package:flutter/material.dart';

import '../model/cart_data.dart';
import 'home_page.dart';
import 'keranjang_page.dart';
import 'pesanan_page.dart';
import 'profil_page.dart';

class DashboardPage extends StatefulWidget {
  final int initialIndex;
  const DashboardPage({super.key, this.initialIndex = 0});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const Color primaryColor = Color(0xFF6B1A2A); // Merah marun tua

  late int currentIndex;

  final List<Widget> pages = const [
    HomePage(),
    KeranjangPage(),
    PesananPage(),
    ProfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    bool isCart = false,
  }) {
    final bool isSelected = currentIndex == index;
    
    // Oval indicator background (merah muda sangat pucat / marun transparan tipis)
    final Color activeIndicatorBg = const Color(0xFF6B1A2A).withOpacity(0.08); 
    final Color activeColor = primaryColor;
    final Color inactiveColor = const Color(0xFFB08090);

    Widget iconWidget = Icon(
      icon,
      color: isSelected ? activeColor : inactiveColor,
      size: 24,
    );

    if (isCart) {
      iconWidget = Badge(
        isLabelVisible: CartData.items.isNotEmpty,
        backgroundColor: primaryColor,
        label: Text(
          "${CartData.items.length}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: iconWidget,
      );
    }

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Background pill animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? activeIndicatorBg : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: iconWidget,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? activeColor : inactiveColor,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.12),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: const Color(0xFFD4A0A8),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: 0,
              icon: Icons.home_rounded,
              label: "Home",
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.shopping_cart_rounded,
              label: "Keranjang",
              isCart: true,
            ),
            _buildNavItem(
              index: 2,
              icon: Icons.inventory_2_rounded,
              label: "Pesanan",
            ),
            _buildNavItem(
              index: 3,
              icon: Icons.person_rounded,
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}
