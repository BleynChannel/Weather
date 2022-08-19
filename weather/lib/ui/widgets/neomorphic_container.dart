import 'package:flutter/material.dart';

class NeomorphicContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final Gradient? gradient;
  final double borderRadius;
  final double distance;
  final double intensity;
  final double blur;
  final Duration duration;
  final Curve curve;

  const NeomorphicContainer({
    Key? key,
    this.child,
    this.color,
    this.gradient,
    this.borderRadius = 0,
    this.distance = 4,
    this.intensity = 0.25,
    this.blur = 4,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
        gradient: gradient,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(distance, distance),
            blurRadius: blur,
            color: Colors.black.withOpacity(intensity),
          ),
          BoxShadow(
            offset: Offset(-distance, -distance),
            blurRadius: blur,
            color: Colors.white.withOpacity(intensity),
          ),
        ],
      ),
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}
