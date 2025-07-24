import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

class AyahAudioPlayer extends StatefulWidget {
  final String audioUrl;

  const AyahAudioPlayer({super.key, required this.audioUrl});

  @override
  State<AyahAudioPlayer> createState() => _AyahAudioPlayerState();
}

class _AyahAudioPlayerState extends State<AyahAudioPlayer>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _player;
  bool isPlaying = false;
  bool isLoading = false;
  double progress = 0.0;
  Timer? _timer;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _onPlaybackComplete();
      }
    });

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0.8,
      upperBound: 1.2,
    );
  }

  void _onPlaybackComplete() {
    if (mounted) {
      setState(() {
        isPlaying = false;
        progress = 0.0;
      });
    }
    _timer?.cancel();
    if (_waveController.isAnimating) {
      _waveController.stop();
    }
  }

  void _startProgress() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final current = _player.position;
      final total = _player.duration;

      if (total != null && total.inMilliseconds != 0) {
        if (mounted) {
          setState(() {
            progress = current.inMilliseconds / total.inMilliseconds;
          });
        }
      }
    });
  }

  Future<void> _togglePlay() async {
    if (isPlaying) {
      await _player.pause();
      _waveController.stop();
      setState(() {
        isPlaying = false;
      });
    } else {
      setState(() => isLoading = true);

      try {
        if (_player.audioSource == null) {
          await _player.setUrl(widget.audioUrl);
        }

        await _player.play();
        _startProgress();

        _waveController.repeat(reverse: true);
        setState(() {
          isPlaying = true;
        });
      } catch (e) {
        debugPrint("Error loading audio: $e");
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _timer?.cancel();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Bar
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerRight,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Play/Pause + Wave + Loading
          Row(
            children: [
              // زر التشغيل أو التحميل
              isLoading
                  ? const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(strokeWidth: 3),
              )
                  : ScaleTransition(
                scale: _waveController,
                child: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 40,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 12),

              // أنيميشن شكل موجة
              if (isPlaying)
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (index) {
                        final delay = index * 200;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            width: 4,
                            height: 15 +
                                (_waveController.value * 10 * (1 + index / 2)),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.8),
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
    );
  }
}

