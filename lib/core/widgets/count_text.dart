import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';
import 'count_action.dart';


class CountText extends StatefulWidget {
  final String count;
  final CountAction? action;

  const CountText({
    super.key,
    required this.count,
    required this.action,
  });

  @override
  State<CountText> createState() => _CountTextState();
}

class _CountTextState extends State<CountText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  bool showActionLabel = false;
  String actionText = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1.5),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CountText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count && widget.action != null) {
      switch (widget.action!) {
        case CountAction.increase:
          actionText = "+1";
          break;
        case CountAction.decrease:
          actionText = "-1";
          break;
        case CountAction.reset:
          actionText = "🔄";
          break;
      }

      showActionLabel = true;
      _controller.forward(from: 0).then((_) {
        setState(() {
          showActionLabel = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: showActionLabel ? 1.15 : 1.0,
          child: Text(
            widget.count,
            style: AppTextStyles.titleStyle.copyWith(
              fontSize: 40,
              shadows: const [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
        if (showActionLabel)
          SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Text(
                actionText,
                style: const TextStyle(
                  fontSize: 28,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black12,
                      offset: Offset(0, 1),
                      blurRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
