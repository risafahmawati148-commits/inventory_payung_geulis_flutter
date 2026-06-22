import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'dashboard_page.dart';

// ─────────────────────────────────────────────
//  Konstanta Warna Payung Geulis
// ─────────────────────────────────────────────
const Color _maroon      = Color(0xFF6B1A2A);
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
  const _PayungGeulisIcon({this.size = 110});

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
//  Splash Page
// ─────────────────────────────────────────────
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double>   _scaleAnim;
  late Animation<double>   _fadeAnim;

  @override
  void initState() {
    super.initState();

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutBack),
    );

    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);

    _animCtrl.forward();

    Timer(
      const Duration(seconds: 3500 ~/ 1000),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DashboardPage(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
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
                    _maroon.withOpacity(0.04),
                    Colors.transparent,
                    _maroon.withOpacity(0.06),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
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
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: _PayungGeulisIcon(size: 100),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "PAYUNG GEULIS",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.5,
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
                    const SizedBox(height: 8),
                    Text(
                      "Khas Tasikmalaya",
                      style: TextStyle(
                        fontSize: 15,
                        color: _textSub,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 60),
                    const SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        color: _maroon,
                        strokeWidth: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
