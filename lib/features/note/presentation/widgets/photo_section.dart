import 'package:flutter/material.dart';

class PhotoSection extends StatelessWidget {
  final String? imagePath;
  const PhotoSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.grey.shade300,
        child: Image.asset(imagePath!, fit: BoxFit.cover),
      ),
    );
  }
}
