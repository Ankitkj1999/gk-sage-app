import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:quiz_app/configs/color_config.dart';

class VPatternPainter extends CustomPainter {
  final Color backgroundColor;
  final Color patternColor;
  final double patternSpacing;

  VPatternPainter({
    this.backgroundColor = ColorConfig.appThemeColor,
    // this.backgroundColor = const Color(0xFF7D62FF),
    this.patternColor = const Color(0xFF9A84FF),
    this.patternSpacing = 350.0, // Increased spacing between V patterns
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Fill background first
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    // Calculate the angle (approx 30 degrees)
    final double angleInRadians = 40 * math.pi / 180;
    final double columnWidth = 100; // Width of each slanted column

    // Calculate how many patterns we need to fill the screen
    int patternsNeeded = (size.height / patternSpacing).ceil() + 1;

    // Create gradient shaders for left and right columns
    final Shader leftShader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        patternColor.withOpacity(0.3),
        patternColor.withOpacity(0.05),
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width / 2, size.height));

    final Shader rightShader = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        patternColor.withOpacity(0.3),
        patternColor.withOpacity(0.05),
      ],
    ).createShader(Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height));

    // Draw the patterns with proper spacing
    for (int i = -3; i < patternsNeeded; i++) {
      final double yPos = i * patternSpacing;

      // Calculate the slant length based on the angle
      final double slantLength = size.width / 2 / math.cos(angleInRadians);

      // Left column (from left edge to center)
      final Path leftColumn = Path();
      leftColumn.moveTo(0, yPos);
      leftColumn.lineTo(size.width / 2, yPos + size.width / 2 * math.tan(angleInRadians));
      leftColumn.lineTo(size.width / 2, yPos + size.width / 2 * math.tan(angleInRadians) + columnWidth);
      leftColumn.lineTo(0, yPos + columnWidth);
      leftColumn.close();

      // Right column (from right edge to center)
      final Path rightColumn = Path();
      rightColumn.moveTo(size.width, yPos);
      rightColumn.lineTo(size.width / 2, yPos + size.width / 2 * math.tan(angleInRadians));
      rightColumn.lineTo(size.width / 2, yPos + size.width / 2 * math.tan(angleInRadians) + columnWidth);
      rightColumn.lineTo(size.width, yPos + columnWidth);
      rightColumn.close();

      // Draw columns with gradient shaders
      canvas.drawPath(leftColumn, Paint()..shader = leftShader);
      canvas.drawPath(rightColumn, Paint()..shader = rightShader);
    }

    // Draw additional offset patterns for more visual interest but with less opacity
    for (int i = -3; i < patternsNeeded; i++) {
      final double yPos = i * patternSpacing + patternSpacing / 2;

      // Left column (offset)
      final Path leftColumn = Path();
      leftColumn.moveTo(0, yPos);
      leftColumn.lineTo(size.width / 2, yPos + size.width / 2 * math.tan(angleInRadians));
      leftColumn.lineTo(size.width / 2, yPos + size.width / 2 * math.tan(angleInRadians) + columnWidth);
      leftColumn.lineTo(0, yPos + columnWidth);
      leftColumn.close();

      // Right column (offset)
      final Path rightColumn = Path();
      rightColumn.moveTo(size.width, yPos);
      rightColumn.lineTo(size.width / 2, yPos + size.width / 2 * math.tan(angleInRadians));
      rightColumn.lineTo(size.width / 2, yPos + size.width / 2 * math.tan(angleInRadians) + columnWidth);
      rightColumn.lineTo(size.width, yPos + columnWidth);
      rightColumn.close();

      // Draw offset columns with more subtle gradients
      final Shader offsetLeftShader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          patternColor.withOpacity(0.2),
          patternColor.withOpacity(0.03),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width / 2, size.height));

      final Shader offsetRightShader = LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          patternColor.withOpacity(0.2),
          patternColor.withOpacity(0.03),
        ],
      ).createShader(Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height));

      canvas.drawPath(leftColumn, Paint()..shader = offsetLeftShader);
      canvas.drawPath(rightColumn, Paint()..shader = offsetRightShader);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Usage example:
// Widget build(BuildContext context) {
//   return Stack(
//     children: [
//       Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: CustomPaint(
//           painter: VPatternPainter(
//             backgroundColor: Color(0xFF7D62FF),
//             patternColor: Color(0xFF9A84FF),
//             patternSpacing: 120.0,
//           ),
//         ),
//       ),
//       // Your other content here
//     ],
//   );
// }