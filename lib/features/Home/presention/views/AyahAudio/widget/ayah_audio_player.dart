import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../cubit/audio_player_cubit.dart';

class AyahAudioPlayer extends StatefulWidget {
  final String audioUrl;

  const AyahAudioPlayer({super.key, required this.audioUrl});

  @override
  State<AyahAudioPlayer> createState() => _AyahAudioPlayerState();
}

class _AyahAudioPlayerState extends State<AyahAudioPlayer> with SingleTickerProviderStateMixin {
  late final AnimationController _waveController;
  late final AudioPlayerCubit _audioCubit;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0.8,
      upperBound: 1.2,
    );
    _audioCubit = AudioPlayerCubit();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _audioCubit.close();
    super.dispose();
  }

  void _handleTap() {
    _audioCubit.togglePlay(widget.audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioPlayerCubit, AudioPlayerState>(
      bloc: _audioCubit,
      listener: (context, state) {
        final isMyAudio = _audioCubit.currentUrl == widget.audioUrl;

        if (!isMyAudio) return;

        print("📥 UI received state: $state");

        if (state is AudioPlayerPlaying) {
          _waveController.repeat(reverse: true);
        } else {
          _waveController.stop();
        }

        if (state is AudioPlayerProgress) {
          setState(() {
            progress = state.progress;
          });
        }

        if (state is AudioPlayerCompleted) {
          setState(() {
            progress = 0.0;
          });
        }
      },
      builder: (context, state) {
        final isMyAudio = _audioCubit.currentUrl == widget.audioUrl;

        final isLoading = state is AudioPlayerLoading && isMyAudio;
        final isPlaying = state is AudioPlayerPlaying && isMyAudio;
        final displayProgress = (state is AudioPlayerProgress && isMyAudio)
            ? state.progress
            : 0.0;

        return GestureDetector(
          onTap: isLoading ? null : _handleTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerRight,
                  widthFactor: displayProgress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Play/Pause + wave + loader
              Row(
                children: [
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
                  if (isPlaying)
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
      },
    );
  }
}
