import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final String title;
  final String imagepath;

  const ImageDisplay({super.key, required this.title, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagepath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        Text(title),
      ],
    );
  }
}
