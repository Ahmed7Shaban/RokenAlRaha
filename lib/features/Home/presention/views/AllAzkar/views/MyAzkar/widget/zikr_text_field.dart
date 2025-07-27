import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../core/theme/app_colors.dart';

class ZikrTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;

  const ZikrTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  State<ZikrTextField> createState() => _ZikrTextFieldState();
}

class _ZikrTextFieldState extends State<ZikrTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  bool _isFocused = false;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
      if (_focusNode.hasFocus) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _colorAnimation = ColorTween(
      begin: AppColors.primaryColor,
      end: Colors.purpleAccent.shade100,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          style: GoogleFonts.cairo(
            fontSize: 18,
            color: _isFocused ? _colorAnimation.value : Colors.black87,
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: GoogleFonts.cairo(
              color: _isFocused ? _colorAnimation.value : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: _isFocused ? _colorAnimation.value : Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: _colorAnimation.value ?? AppColors.primaryColor,
                width: 2.5,
              ),
            ),
            filled: true,
            fillColor: _isFocused ? _colorAnimation.value?.withOpacity(0.05) : AppColors.pureWhite
          ),
        );
      },
    );
  }
}
