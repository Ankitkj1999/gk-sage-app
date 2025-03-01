import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String assetString;
  final String title;
  const EmptyContent(
      {super.key, required this.assetString, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              assetString,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
