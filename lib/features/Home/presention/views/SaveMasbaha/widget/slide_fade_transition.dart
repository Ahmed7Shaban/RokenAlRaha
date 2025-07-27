import 'package:flutter/material.dart';

class SlideFadeTransition extends StatelessWidget {
  final Widget child;
  final int index;

  const SlideFadeTransition({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 50)),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)), // يظهر من تحت
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
