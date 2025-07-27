import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../source/app_images.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ZikrItem extends StatefulWidget {
  final String title;
  final int initialCount;
  final VoidCallback? onTap;

  const ZikrItem({
    super.key,
    required this.title,
    this.initialCount = 1,
    this.onTap,
  });

  @override
  State<ZikrItem> createState() => _ZikrItemState();
}

class _ZikrItemState extends State<ZikrItem> with SingleTickerProviderStateMixin {
  late int _count; // العدّاد المتغير
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _offsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _shareContent() {
    Share.share(widget.title);
  }

  void _handleBottomTap() {
    if (_count == 0) return; // لو وصل 0، بطل الضغط

    setState(() {
      _count--;
    });

    _controller.forward(from: 0);
  }

  void _handleLongPress() {
    setState(() {
      _count = widget.initialCount; // إعادة تعيين
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.pureWhite, AppColors.primaryColor],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.goldenYellow, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: AppTextStyles.titleStyle.copyWith(
                          fontSize: 24,
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
                    GestureDetector(
                      onTap: _shareContent,
                      child: Image.asset(
                        Assets.share,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _handleBottomTap,
                onLongPress: _handleLongPress,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_offsetAnimation.value, 0),
                      child: child,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 100,
                    decoration: BoxDecoration(
                      color: _count == 0 ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.goldenYellow, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "$_count",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
