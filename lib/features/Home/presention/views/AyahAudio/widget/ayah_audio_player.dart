import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/lottie_loader.dart';
import '../cubit/audio_player_cubit.dart';
import '../cubit/audio_player_state.dart';

class AyahAudioPlayer extends StatefulWidget {
  final String audioUrl;
  final AudioPlayerCubit audioCubit;

  const AyahAudioPlayer({
    super.key,
    required this.audioUrl,
    required this.audioCubit,
  });

  @override
  State<AyahAudioPlayer> createState() => _AyahAudioPlayerState();
}

class _AyahAudioPlayerState extends State<AyahAudioPlayer>
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
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  // 🎯 تشغيل/إيقاف عند الضغط
  void _handleTap() {
    widget.audioCubit.togglePlay(widget.audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioPlayerCubit, AudioPlayerState>(
      bloc: widget.audioCubit,
      listener: (context, state) {
        // ❗ إظهار رسالة خطأ إذا فشل التشغيل
        if (state is AudioPlayerError &&
            widget.audioCubit.currentUrl == widget.audioUrl) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('حدث خطأ أثناء تشغيل الصوت'),
              backgroundColor: Colors.red.shade400,
              action: SnackBarAction(
                label: 'إعادة المحاولة',
                textColor: Colors.white,
                onPressed: () {
                  widget.audioCubit.togglePlay(widget.audioUrl);
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final isCurrent = widget.audioCubit.currentUrl == widget.audioUrl;
        final isLoading = state is AudioPlayerLoading && isCurrent;
        final isPlaying = state is AudioPlayerPlaying && isCurrent;
        final isCompleted = state is AudioPlayerCompleted && isCurrent;
        final displayProgress = (state is AudioPlayerProgress && isCurrent)
            ? state.progress
            : 0.0;

        // 🕺 تفعيل حركة الموجة عند التشغيل
        if (isPlaying) {
          _waveController.repeat(reverse: true);
        } else {
          _waveController.stop();
          _waveController.value = 1.0;
        }

        return GestureDetector(
          onTap: isLoading ? null : _handleTap,
          child: Column(
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

              Row(
                children: [
                  if (isLoading)
                    const LottieLoader(width: 30, height: 30)
                  else
                Lottie.asset(
                  "assets/lottie/AudioPlaying.json",
                  width: 50,
                  height: 50,
                )


                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
