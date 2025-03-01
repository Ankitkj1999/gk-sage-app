import 'dart:math';
import 'package:flutter/material.dart';

class MultipleCubesPainterService extends CustomPainter {
  final _random = Random(12); // fixed seed for consistent results

  @override
  void paint(Canvas canvas, Size size) {
    // Try adjusting these parameters:
    const int numberOfCubes = 10; // how many cubes
    const int maxAttempts = 100; // attempts to place each cube
    const double minEdge = 50.0; // minimum cube edge
    const double maxEdge = 100.0; // maximum cube edge

    // We’ll keep track of each placed cube’s (center, size) in a list
    final List<_CubeData> placedCubes = [];

    for (int i = 0; i < numberOfCubes; i++) {
      bool placed = false;
      int attempts = 0;

      while (!placed && attempts < maxAttempts) {
        // Random size
        final double s = _random.nextDouble() * (maxEdge - minEdge) + minEdge;

        // For isometric diamond, the radius from center to any corner is ~ s
        // so we’ll use s for overlap checking

        // Generate random center in [0, width], [0, height]
        // You might clamp to ensure the entire cube stays on-screen
        final double cx = _random.nextDouble() * size.width;
        final double cy = _random.nextDouble() * size.height;

        // Check distance to all previously placed cubes
        bool ok = true;
        for (final c in placedCubes) {
          final double dx = c.center.dx - cx;
          final double dy = c.center.dy - cy;
          final double dist = sqrt(dx * dx + dy * dy);
          // If distance < sum of “radii” => overlap
          // We approximate each cube’s “radius” by its edge length s
          if (dist < (c.size + s)) {
            ok = false;
            break;
          }
        }

        if (ok) {
          // Place the new cube
          placedCubes.add(_CubeData(Offset(cx, cy), s));
          placed = true;
        }
        attempts++;
      }
    }

    // Now draw all placed cubes
    // Adjust face colors / opacities to your preference
    final Paint topPaint = Paint()..color = Colors.white.withOpacity(0.1);
    final Paint sidePaint = Paint()..color = Colors.white.withOpacity(0.05);

    for (final c in placedCubes) {
      _drawIsometricCube(canvas, c.center, c.size, topPaint, sidePaint);
    }
  }

  void _drawIsometricCube(
    Canvas canvas,
    Offset center,
    double s,
    Paint topPaint,
    Paint sidePaint,
  ) {
    // Isometric projection factors
    final double offsetX = s * 0.866; // cos(30°)
    final double offsetY = s * 0.5; // sin(30°)

    // Top face (diamond) around the center
    final Offset A = center;
    final Offset B = Offset(A.dx + offsetX, A.dy + offsetY);
    final Offset D = Offset(A.dx - offsetX, A.dy + offsetY);
    final Offset C = Offset(A.dx, A.dy + 2 * offsetY);

    // Vertical extension for side faces (equal to s => “cube”)
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
