import 'package:flutter/material.dart';
class PrefetchedImages extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final bool? circularShape;

  const PrefetchedImages({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.circularShape
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
            bottomLeft: Radius.circular(circularShape == false ? 0 : radius),
            bottomRight: Radius.circular(circularShape == false ? 0 : radius)
        ),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (frame == null) {
              return Container(color: Colors.grey[300]);
            }
            return child;
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error),
            );
          },
        )
            : Container(color: Colors.grey[300])
    );
  }
}