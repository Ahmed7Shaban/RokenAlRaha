import 'package:flutter/material.dart';

class AudioVisualizerBar extends StatelessWidget {
  const AudioVisualizerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + i * 100),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 4,
          height: 10.0 + (i.isEven ? 20 : 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
