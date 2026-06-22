import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../model/user_model.dart';
import 'dashboard_page.dart';
import 'login_page.dart';

// ─────────────────────────────────────────────
//  Konstanta Warna Payung Geulis
// ─────────────────────────────────────────────
const Color _maroon      = Color(0xFF6B1A2A);
const Color _maroonLight = Color(0xFF8B2338);
const Color _cream       = Color(0xFFFAF3E0);
const Color _gold        = Color(0xFFB8860B);
const Color _goldLight   = Color(0xFFD4A843);
const Color _textDark    = Color(0xFF3D0C14);
const Color _textSub     = Color(0xFF8B5E6B);

// ─────────────────────────────────────────────
//  Custom Painter — Pola Batik Parang
// ─────────────────────────────────────────────
class _ParangPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _maroon.withOpacity(0.045)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double step = 38.0;
    const double curveMag = 10.0;

    for (double y = -step; y < size.height + step * 2; y += step) {
      for (double x = -step; x < size.width + step * 2; x += step) {
        final path = Path();
        path.moveTo(x, y);
        path.relativeCubicTo(
          curveMag, -curveMag,
          step - curveMag, -curveMag,
          step, 0,
        );
        canvas.drawPath(path, paint);

        final paint2 = Paint()
          ..color = _maroon.withOpacity(0.03)
          ..strokeWidth = 0.8
          ..style = PaintingStyle.stroke;

        canvas.drawLine(
          Offset(x + step * 0.5, y - step * 0.3),
          Offset(x + step * 0.5, y + step * 0.3),
          paint2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
//  Custom Painter — Ilustrasi Payung Geulis Emas
// ─────────────────────────────────────────────
class _PayungGeulisIcon extends StatelessWidget {
  final double size;
  const _PayungGeulisIcon({this.size = 80});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PayungPainter(),
      ),
    );
  }
}

class _PayungPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.48;
    final w = size.width;

    final maroonPaint = Paint()
      ..color = const Color(0xFF6B1A2A)
      ..style = PaintingStyle.fill;

    final goldStroke = Paint()
      ..color = const Color(0xFFD4A843)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final goldFill = Paint()
      ..color = const Color(0xFFD4A843)
      ..style = PaintingStyle.fill;

    // 1. Spire / Top Tip (Mahkota Payung Emas)
    final spirePath = Path()
      ..moveTo(cx - 3, cy - 25)
      ..lineTo(cx + 3, cy - 25)
      ..lineTo(cx, cy - 35)
      ..close();
    canvas.drawPath(spirePath, goldFill);
    canvas.drawCircle(Offset(cx, cy - 36), 1.8, goldFill);

    // 2. Shaft / Stick
    canvas.drawLine(
      Offset(cx, cy - 25),
      Offset(cx, cy + 28),
      Paint()
        ..color = const Color(0xFFD4A843)
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round,
    );

    // 3. Canopy Shape (Kubah Payung - Maroon)
    final canopyPath = Path()
      ..moveTo(cx - 32, cy)
      ..quadraticBezierTo(cx - 30, cy - 24, cx, cy - 25)
      ..quadraticBezierTo(cx + 30, cy - 24, cx + 32, cy)
      // Bottom edge scallops (bergelombang)
      ..quadraticBezierTo(cx + 24, cy + 2, cx + 16, cy)
      ..quadraticBezierTo(cx + 8, cy + 2, cx, cy)
      ..quadraticBezierTo(cx - 8, cy + 2, cx - 16, cy)
      ..quadraticBezierTo(cx - 24, cy + 2, cx - 32, cy)
      ..close();
    canvas.drawPath(canopyPath, maroonPaint);

    // 4. Gold Ribs / Jari-jari
    final ribPoints = [
      Offset(cx - 32, cy),
      Offset(cx - 16, cy),
      Offset(cx, cy),
      Offset(cx + 16, cy),
      Offset(cx + 32, cy),
    ];
    for (var pt in ribPoints) {
      canvas.drawLine(Offset(cx, cy - 25), pt, goldStroke..strokeWidth = 0.7);
    }

    // 5. Intricate Gold Lace Patterns (Motif Emas di Kubah)
    final lacePath1 = Path()
      ..moveTo(cx - 32, cy)
      ..quadraticBezierTo(cx - 30, cy - 24, cx, cy - 25)
      ..quadraticBezierTo(cx + 30, cy - 24, cx + 32, cy);
    canvas.drawPath(lacePath1, goldStroke..strokeWidth = 1.2);

    // Inner lace arches
    final lacePath2 = Path()
      ..moveTo(cx - 24, cy - 6)
      ..quadraticBezierTo(cx - 22, cy - 18, cx, cy - 19)
      ..quadraticBezierTo(cx + 22, cy - 18, cx + 24, cy - 6);
    canvas.drawPath(lacePath2, goldStroke..strokeWidth = 1.0);

    // Little gold arches/scallops on the bottom edge inside
    final bottomLace = Path()
      ..moveTo(cx - 32, cy)
      ..quadraticBezierTo(cx - 24, cy - 4, cx - 16, cy)
      ..quadraticBezierTo(cx - 8, cy - 4, cx, cy)
      ..quadraticBezierTo(cx + 8, cy - 4, cx + 16, cy)
      ..quadraticBezierTo(cx + 24, cy - 4, cx + 32, cy);
    canvas.drawPath(bottomLace, goldStroke..strokeWidth = 1.0);

    // Tiny dots/stars details
    canvas.drawCircle(Offset(cx - 10, cy - 10), 1.0, goldFill);
    canvas.drawCircle(Offset(cx + 10, cy - 10), 1.0, goldFill);
    canvas.drawCircle(Offset(cx, cy - 12), 1.2, goldFill);

    // 6. Hanging Tassels (Rumbai Emas)
    final tasselPoints = [
      Offset(cx - 24, cy + 1),
      Offset(cx - 16, cy),
      Offset(cx - 8, cy + 1),
      Offset(cx, cy),
      Offset(cx + 8, cy + 1),
      Offset(cx + 16, cy),
      Offset(cx + 24, cy + 1),
    ];
    for (var pt in tasselPoints) {
      canvas.drawLine(pt, Offset(pt.dx, pt.dy + 5), goldStroke..strokeWidth = 0.7);
      canvas.drawCircle(Offset(pt.dx, pt.dy + 6), 1.0, goldFill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
//  Register Page
// ─────────────────────────────────────────────
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final _namaController     = TextEditingController();
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading      = false;
  bool _hidePassword = true;

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<Offset>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim  = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_namaController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: _maroon,
          content: const Text(
            'Lengkapi nama lengkap, alamat email, dan kata sandi',
            style: TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _loading = true);

    UserModel? user = await AuthService.register(
      nama:     _namaController.text,
      email:    _emailController.text,
      password: _passwordController.text,
    );

    setState(() => _loading = false);

    if (user != null) {
      UserModel.currentUser = user;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: _maroon,
          content: Text(
            'Registrasi berhasil! Selamat datang, ${user.nama}',
            style: const TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: _maroon,
          content: const Text(
            'Registrasi gagal. Silakan coba kembali.',
            style: TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: _cream),
          Positioned.fill(
            child: CustomPaint(painter: _ParangPainter()),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _maroon.withOpacity(0.06),
                    Colors.transparent,
                    _maroon.withOpacity(0.04),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              _gold.withOpacity(0.18),
                              _cream.withOpacity(0.0),
                            ],
                          ),
                          border: Border.all(
                            color: _gold.withOpacity(0.35),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _gold.withOpacity(0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: _PayungGeulisIcon(size: 72),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'PAYUNG GEULIS',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.8,
                          color: _textDark,
                          shadows: [
                            Shadow(
                              color: _maroon.withOpacity(0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: _gold.withOpacity(0.5),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.auto_awesome,
                                size: 10,
                                color: _gold.withOpacity(0.7),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: _gold.withOpacity(0.5),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBF0),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: _maroon.withOpacity(0.22),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _maroon.withOpacity(0.08),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daftar Akun Baru',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Lengkapi formulir untuk bergabung',
                              style: TextStyle(
                                fontSize: 13,
                                color: _textSub,
                              ),
                            ),
                            const SizedBox(height: 22),

                            // ── Nama Lengkap
                            TextField(
                              controller: _namaController,
                              style: const TextStyle(
                                color: _textDark,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Nama Lengkap',
                                hintText: 'Masukkan nama lengkap Anda',
                                prefixIcon: const Icon(Icons.person_outline),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                    color: _maroon,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                    color: _maroonLight,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            // ── Alamat Email
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: _textDark,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Alamat Email',
                                hintText: 'contoh@email.com',
                                prefixIcon: const Icon(Icons.email_outlined),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                    color: _maroon,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                    color: _maroonLight,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            // ── Kata Sandi
                            TextField(
                              controller: _passwordController,
                              obscureText: _hidePassword,
                              style: const TextStyle(
                                color: _textDark,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Kata Sandi',
                                hintText: '••••••••',
                                prefixIcon: const Icon(Icons.lock_outline),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                    color: _maroon,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                    color: _maroonLight,
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(
                                      () => _hidePassword = !_hidePassword),
                                  icon: Icon(
                                    _hidePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // ── Tombol Daftar
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: _loading ? null : _register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _maroon,
                                  foregroundColor: Colors.white,
                                  elevation: 3,
                                  shadowColor: _maroon.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: _loading
                                    ? const SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Text(
                                        'Daftar',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // ── Link Masuk
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      color: _textSub,
                                      fontFamily: 'Quicksand',
                                    ),
                                    children: const [
                                      TextSpan(text: 'Sudah punya akun? '),
                                      TextSpan(
                                        text: 'Masuk',
                                        style: TextStyle(
                                          color: _maroon,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationColor: _maroon,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '— Payung Geulis, Tasikmalaya —',
                        style: TextStyle(
                          fontSize: 11,
                          color: _textSub.withOpacity(0.6),
                          letterSpacing: 0.8,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
