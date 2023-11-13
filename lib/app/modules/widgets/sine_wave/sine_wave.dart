import 'dart:math' as math;
import 'package:flutter/material.dart';

class SineWaveWidget extends StatefulWidget {
  @override
  _SineWaveWidgetState createState() => _SineWaveWidgetState();
}

class _SineWaveWidgetState extends State<SineWaveWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<double> phaseShifts;

  @override
  void initState() {
    super.initState();
    final int waveCount = 6;
    // Generate a random phase shift for each wave
    phaseShifts = List.generate(waveCount, (index) => math.Random().nextDouble() * math.pi * 2);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          painter: SineWavePainter(_animationController.value, phaseShifts),
          size: Size.infinite,
        );
      },
    );
  }
}

class SineWavePainter extends CustomPainter {
  final double animationValue;
  final List<double> phaseShifts;
  SineWavePainter(this.animationValue, this.phaseShifts);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5) // Adjust the opacity
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    int waveCount = phaseShifts.length;
    for (int i = 0; i < waveCount; i++) {
      final path = Path();
      double amplitude = 6 + (i * 4);
      double frequency = 3 * 2 * math.pi / size.width; // Set frequency to 3

      for (double x = 0; x <= size.width; x++) {
        double phase = phaseShifts[i] + animationValue * 2 * math.pi; // Random phase shift
        double y = math.sin((x * frequency) + phase) * amplitude;
        y += size.height / 2; // Center the wave vertically

        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MaterialApp(home: Scaffold(body: Center(child: SineWaveWidget()))));
}
