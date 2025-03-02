import 'package:flutter/material.dart';

class Podium extends StatelessWidget {
  /// Creates a 3D podium visualization
  ///
  /// [width] and [height] define the overall size of the podium area
  /// [showNumbers] controls whether position numbers are shown on the podium blocks
  const Podium({
    Key? key,
    this.width = double.infinity,
    this.height = 200,
    this.showNumbers = true,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  final double width;
  final double height;
  final bool showNumbers;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      child: CustomPaint(
        size: Size(width, height),
        painter: PodiumPainter(showNumbers: showNumbers),
      ),
    );
  }
}

class PodiumPainter extends CustomPainter {
  final bool showNumbers;

  PodiumPainter({this.showNumbers = true});

  @override
  void paint(Canvas canvas, Size size) {
    // Dimensions for the podium blocks
    final double centerX = size.width / 2;
    final double bottomY = size.height * 0.95; // Position near bottom

    // Increased block width from 0.25 to 0.32 to make blocks wider
    final double blockWidth = size.width * 0.32;
    final double blockDepth = blockWidth * 0.2; // Reduced depth for flatter appearance

    // Heights for each placement (1st tallest, 2nd medium, 3rd shortest)
    final double firstHeight = size.height * 0.75;
    final double secondHeight = size.height * 0.55;
    final double thirdHeight = size.height * 0.45;

    // Adjust spacing to ensure blocks are properly positioned with the wider width
    final double spacing = blockWidth; // Use full block width as the base spacing

    // Draw second place (left) - Position 2
    drawIsometricBlock(
      canvas,
      Offset(centerX - spacing, bottomY),
      blockWidth,
      blockDepth,
      secondHeight,
      2,
    );

    // Draw first place (center) - Position 1
    drawIsometricBlock(
      canvas,
      Offset(centerX, bottomY),
      blockWidth,
      blockDepth,
      firstHeight,
      1,
    );

    // The right edge of the 1st block becomes the left edge of the 3rd block
    // This ensures perfect alignment of the front faces
    final double thirdBlockX = centerX + blockWidth;

    // Draw third place (right) - Position 3
    drawIsometricBlock(
      canvas,
      Offset(thirdBlockX, bottomY),
      blockWidth,
      blockDepth,
      thirdHeight,
      3,
    );
  }

  void drawIsometricBlock(
      Canvas canvas,
      Offset bottomCenter,
      double width,
      double depth,
      double height,
      int position,
      ) {
    // Calculate the corners of the top face
    final double halfWidth = width / 2;
    final double halfDepth = depth / 2;

    // Enhanced isometric effect with more perspective
    // Adjusted perspective for better connected appearance
    final double isoAngle = 0.45;

    // Bottom center point
    final Offset center = bottomCenter;

    // Top center point (shifted up by height)
    final Offset topCenter = Offset(center.dx, center.dy - height);

    // Adjust top face corners based on position for connecting edges
    double leftPerspective = 0.85;
    double rightPerspective = 0.85;

    // For position 2 (left), make right edge connect to position 1
    if (position == 2) {
      rightPerspective = 0.95; // Less taper on right side to connect to position 1
    }

    // For position 3 (right), make left edge connect to position 1
    if (position == 3) {
      leftPerspective = 0.95; // Less taper on left side to connect to position 1
    }

    // Top face corners with adjusted perspective for connections
    final Offset topFrontLeft = Offset(
      topCenter.dx - halfWidth,
      topCenter.dy + halfDepth * isoAngle,
    );
    final Offset topFrontRight = Offset(
      topCenter.dx + halfWidth,
      topCenter.dy + halfDepth * isoAngle,
    );
    final Offset topBackLeft = Offset(
      topCenter.dx - halfWidth * leftPerspective,
      topCenter.dy - halfDepth * isoAngle,
    );
    final Offset topBackRight = Offset(
      topCenter.dx + halfWidth * rightPerspective,
      topCenter.dy - halfDepth * isoAngle,
    );

    // Bottom face corners
    final Offset bottomFrontLeft = Offset(
      center.dx - halfWidth,
      center.dy + halfDepth * isoAngle,
    );
    final Offset bottomFrontRight = Offset(
      center.dx + halfWidth,
      center.dy + halfDepth * isoAngle,
    );

    // Colors for the faces - using the specific colors provided
    final Color topColor = const Color(0xFFC3B6FE); // Same color for all top faces

    // Front face color depends on position
    Color getFrontColor(int position) {
      switch(position) {
        case 1: return const Color(0xFFA491FD); // 1st place front
        case 2: return const Color(0xFF866DFF); // 2nd place front
        case 3: return const Color(0xFF866DFF); // 3rd place front
        default: return const Color(0xFF866DFF);
      }
    }

    // Draw only the visible faces (top and front)

    // Top face
    final Path topPath = Path()
      ..moveTo(topFrontLeft.dx, topFrontLeft.dy)
      ..lineTo(topFrontRight.dx, topFrontRight.dy)
      ..lineTo(topBackRight.dx, topBackRight.dy)
      ..lineTo(topBackLeft.dx, topBackLeft.dy)
      ..close();

    canvas.drawPath(topPath, Paint()..color = topColor);

    // Front face
    final Path frontPath = Path()
      ..moveTo(topFrontLeft.dx, topFrontLeft.dy)
      ..lineTo(topFrontRight.dx, topFrontRight.dy)
      ..lineTo(bottomFrontRight.dx, bottomFrontRight.dy)
      ..lineTo(bottomFrontLeft.dx, bottomFrontLeft.dy)
      ..close();

    canvas.drawPath(frontPath, Paint()..color = getFrontColor(position));

    // Draw position number on front face if showNumbers is true
    if (showNumbers) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: position.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.5, // Slightly smaller font relative to block width
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      // Center the number on the front face
      final double frontCenterX = (topFrontLeft.dx + topFrontRight.dx + bottomFrontLeft.dx + bottomFrontRight.dx) / 4;
      final double frontCenterY = (topFrontLeft.dy + topFrontRight.dy + bottomFrontLeft.dy + bottomFrontRight.dy) / 4;

      textPainter.paint(
        canvas,
        Offset(
          frontCenterX - textPainter.width / 2,
          frontCenterY - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}