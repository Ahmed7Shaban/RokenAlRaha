import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../../../source/app_images.dart';
import '../model/zikr_model.dart';

class ZikryItem extends StatefulWidget {
  final ZikrModel zikr;
  final VoidCallback? onDeleted;

  const ZikryItem({
    super.key,
    required this.zikr,
    this.onDeleted,
  });

  @override
  State<ZikryItem> createState() => _ZikryItemState();
}

class _ZikryItemState extends State<ZikryItem> with SingleTickerProviderStateMixin {
  late int _count;
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _count = widget.zikr.count;

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
    Share.share("${widget.zikr.title}\n\n${widget.zikr.content}");
  }

  void _handleBottomTap() {
    if (_count == 0) return;

    setState(() {
      _count--;
    });

    _controller.forward(from: 0);
  }

  void _handleLongPress() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (widget.onDeleted != null) widget.onDeleted!();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Dismissible(
        key: ValueKey(widget.zikr.key), // ✅ استخدم مفتاح Hive
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Lottie.asset(
            'assets/lottie/DeleteIcon.json',
            width: 100,
            repeat: false,
          ),
        ),
        onDismissed: (direction) {
          if (widget.onDeleted != null) widget.onDeleted!();
        },
        child: GestureDetector(
          onTap: () {},
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
                // Title + Share
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.zikr.title,
                              style: AppTextStyles.titleStyle.copyWith(fontSize: 20),
                            ),
                            const SizedBox(height: 6),
                            Center(
                              child: Text(
                                widget.zikr.content,
                                style: AppTextStyles.titleStyle.copyWith(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: _shareContent,
                        child: Image.asset(
                          Assets.share,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Counter + Interaction
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
                      height: 90,
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
      ),
    );
  }
}
