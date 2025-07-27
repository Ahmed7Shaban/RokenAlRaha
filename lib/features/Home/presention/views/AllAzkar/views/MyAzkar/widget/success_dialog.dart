import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 100,
        ).animate().scale(duration: 500.ms).then().shake(),
      ),
    );
  }
}
