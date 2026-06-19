import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'page/login_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Palet warna hangat & elegan — Payung Geulis
  static const Color primaryColor = Color(0xFF6B1A2A);   // Merah marun tua
  static const Color accentColor  = Color(0xFF8B2338);   // Marun terang (hover/fokus)
  static const Color textColor    = Color(0xFF3D0C14);   // Teks gelap marun
  static const Color scaffoldBg   = Color(0xFFFAF3E0);   // Krem muda hangat
  static const Color cardBg       = Color(0xFFFFFBF0);   // Krem sangat terang
  static const Color borderColor  = Color(0xFF6B1A2A);   // Border marun
  static const Color subtleText   = Color(0xFF8B5E6B);   // Teks sekunder

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Payung Geulis",
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: scaffoldBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentColor,
          surface: scaffoldBg,
        ),
        textTheme: GoogleFonts.quicksandTextTheme(
          ThemeData.light().textTheme.apply(
                bodyColor: textColor,
                displayColor: textColor,
              ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: scaffoldBg,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: primaryColor),
          titleTextStyle: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ),
        cardTheme: CardThemeData(
          color: cardBg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(
              color: Color(0xFFD4A0A8),
              width: 1.5,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          prefixIconColor: primaryColor,
          suffixIconColor: primaryColor,
          labelStyle: const TextStyle(
            color: subtleText,
            fontWeight: FontWeight.w600,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFFB08090),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: borderColor,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: borderColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: accentColor,
              width: 2,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: primaryColor.withOpacity(0.35),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            minimumSize: const Size(
              double.infinity,
              55,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 0.8,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: const BorderSide(
              color: primaryColor,
              width: 2,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            minimumSize: const Size(
              double.infinity,
              55,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
