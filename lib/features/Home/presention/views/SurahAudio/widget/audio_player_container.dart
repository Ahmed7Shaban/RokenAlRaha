import 'package:flutter/material.dart';
import 'package:roken_raha/core/widgets/lottie_loader.dart';

import '../../../../../../core/theme/app_colors.dart';

class AudioPlayerContainer extends StatefulWidget {
  final bool isLoading;
  final bool isPlaying;
  final double progress;
  final VoidCallback onTap;

  const AudioPlayerContainer({
    super.key,
    required this.isLoading,
    required this.isPlaying,
    required this.progress,
    required this.onTap,
  });

  @override
  State<AudioPlayerContainer> createState() => _AudioPlayerContainerState();
}

class _AudioPlayerContainerState extends State<AudioPlayerContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0.8,
      upperBound: 1.2,
    );

    if (widget.isPlaying) {
      _waveController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant AudioPlayerContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_waveController.isAnimating) {
      _waveController.repeat(reverse: true);
    } else if (!widget.isPlaying && _waveController.isAnimating) {
      _waveController.stop();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerRight,
                widthFactor: widget.progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color:AppColors.goldenYellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                widget.isLoading
                    ? LottieLoader(width: 50,height: 50,)
                    : ScaleTransition(
                  scale: _waveController,
                  child: Icon(
                    widget.isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    size: 40,
                    color:AppColors.goldenYellow,
                  ),
                ),
                const SizedBox(width: 12),

                if (widget.isPlaying)
                  AnimatedBuilder(
                    animation: _waveController,
                    builder: (context, child) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(
                              width: 4,
                              height: 15 +
                                  (_waveController.value * 10 * (1 + index / 2)),
                              decoration: BoxDecoration(
                                  color:AppColors.goldenYellow,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
