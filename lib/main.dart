import 'package:flutter/material.dart';

import 'page/login_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(
    0xFFFFB6A3,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Payung Geulis",
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xFFFFF9F7,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
