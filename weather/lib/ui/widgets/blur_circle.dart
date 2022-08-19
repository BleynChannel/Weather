import 'package:flutter/material.dart';

class BlurCircle extends StatelessWidget {
  final Color? color;
  final double size;
  final double blurRadius;

  const BlurCircle({
    Key? key,
    this.color,
    this.size = 160,
    this.blurRadius = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
              color: color?.withOpacity(0.5) ?? Colors.white, blurRadius: blurRadius)
        ],
      ),
    );
  }
}
