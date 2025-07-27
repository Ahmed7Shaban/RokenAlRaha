
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/masbaha_cubit.dart';

class ResetButtonAnimated extends StatefulWidget {
  const ResetButtonAnimated({super.key, required this.onResetWithAction});
  final VoidCallback onResetWithAction;

  @override
  State<ResetButtonAnimated> createState() => _ResetButtonAnimatedState();
}

class _ResetButtonAnimatedState extends State<ResetButtonAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _shakeAnimation = TweenSequence<Offset>([
      TweenSequenceItem(tween: Tween(begin: Offset.zero, end: const Offset(-0.05, 0)), weight: 1),
      TweenSequenceItem(tween: Tween(begin: const Offset(-0.05, 0), end: const Offset(0.05, 0)), weight: 1),
      TweenSequenceItem(tween: Tween(begin: const Offset(0.05, 0), end: Offset.zero), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _runShake() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _shakeAnimation,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: IconButton(
              icon: const Icon(Icons.refresh, size: 20, color: Colors.black),
              onPressed: () {
                _runShake();
                widget.onResetWithAction();

              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'إعادة',
            style: GoogleFonts.cairo(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
