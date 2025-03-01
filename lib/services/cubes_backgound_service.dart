import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CachedCubesPainter extends CustomPainter {
  // Store the cube positions and sizes statically so they're only calculated once
  static final List<_CubeData> _cachedCubes = _generateCubes();
  final Color backgroundColor;

  CachedCubesPainter({
    this.backgroundColor = const Color(0xFF7254FF),
  });

  // Generate the cubes once when the class is loaded
  static List<_CubeData> _generateCubes() {
    const int numberOfCubes = 10;
    const double minEdge = 50.0;
    const double maxEdge = 100.0;
    final random = Random(12); // Fixed seed

    final List<_CubeData> cubes = [];
    final Size virtualSize = const Size(500, 300); // Virtual canvas size

    for (int i = 0; i < numberOfCubes; i++) {
      bool placed = false;
      int attempts = 0;

      while (!placed && attempts < 100) {
        final double s = random.nextDouble() * (maxEdge - minEdge) + minEdge;
        final double cx = random.nextDouble() * virtualSize.width;
        final double cy = random.nextDouble() * virtualSize.height;

        bool ok = true;
        for (final c in cubes) {
          final double dx = c.center.dx - cx;
          final double dy = c.center.dy - cy;
          final double dist = sqrt(dx * dx + dy * dy);
          if (dist < (c.size + s) * 0.7) { // Allow some overlap
            ok = false;
            break;
          }
        }

        if (ok) {
          cubes.add(_CubeData(Offset(cx, cy), s));
          placed = true;
        }
        attempts++;
      }
    }

    return cubes;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Fill background first
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    // Apply scaling to fit the cubes to the actual canvas size
    final scaleX = size.width / 500;
    final scaleY = size.height / 300;

    // Draw all cubes with proper scaling
    final Paint topPaint = Paint()..color = Colors.white.withOpacity(0.1);
    final Paint sidePaint = Paint()..color = Colors.white.withOpacity(0.07);

    for (final cube in _cachedCubes) {
      // Scale the cube position
      final scaledCenter = Offset(
          cube.center.dx * scaleX,
          cube.center.dy * scaleY
      );
      final scaledSize = cube.size * min(scaleX, scaleY);

      _drawIsometricCube(canvas, scaledCenter, scaledSize, topPaint, sidePaint);
    }
  }

  void _drawIsometricCube(
      Canvas canvas,
      Offset center,
      double s,
      Paint topPaint,
      Paint sidePaint,
      ) {
    final double offsetX = s * 0.866; // cos(30°)
    final double offsetY = s * 0.5;   // sin(30°)

    final Offset A = center;
    final Offset B = Offset(A.dx + offsetX, A.dy + offsetY);
    final Offset D = Offset(A.dx - offsetX, A.dy + offsetY);
    final Offset C = Offset(A.dx, A.dy + 2 * offsetY);

    final Offset Bp = Offset(B.dx, B.dy + s);
    final Offset Dp = Offset(D.dx, D.dy + s);
    final Offset Cp = Offset(C.dx, C.dy + s);

    // Top face
    final Path topPath = Path()
      ..moveTo(A.dx, A.dy)
      ..lineTo(B.dx, B.dy)
      ..lineTo(C.dx, C.dy)
      ..lineTo(D.dx, D.dy)
      ..close();
    canvas.drawPath(topPath, topPaint);

    // Right face
    final Path rightPath = Path()
      ..moveTo(B.dx, B.dy)
      ..lineTo(C.dx, C.dy)
      ..lineTo(Cp.dx, Cp.dy)
      ..lineTo(Bp.dx, Bp.dy)
      ..close();
    canvas.drawPath(rightPath, sidePaint);

    // Left face
    final Path leftPath = Path()
      ..moveTo(D.dx, D.dy)
      ..lineTo(C.dx, C.dy)
      ..lineTo(Cp.dx, Cp.dy)
      ..lineTo(Dp.dx, Dp.dy)
      ..close();
    canvas.drawPath(leftPath, sidePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CubeData {
  final Offset center;
  final double size;
  _CubeData(this.center, this.size);
}