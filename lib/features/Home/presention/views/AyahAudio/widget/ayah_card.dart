import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/ayah_text.dart';
import '../../../../../../source/app_images.dart';
import '../cubit/audio_player_cubit.dart';
import 'ayah_action_buttons.dart';
import 'ayah_audio_player.dart';

class AyahCard extends StatelessWidget {
  final int ayahNumber;
  final String ayahText;
  final String surahName;
  final String audioUrl;
  final AudioPlayerCubit audioCubit;

  const AyahCard({
    super.key,
    required this.ayahNumber,
    required this.surahName,
    required this.ayahText,
    required this.audioUrl,
    required this.audioCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [AppColors.pureWhite, AppColors.primaryColor],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionsButtons( ayahShare: ayahText, ayahNumber: ayahNumber, surahName: surahName, ayahText: ayahText, audioUrl: audioUrl,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(Assets.imagesNumberAya),
                    Text(
                      ayahNumber.toString(),
                      style: AppTextStyles.ayahNumberStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            AyahText(ayahText: ayahText),
            const SizedBox(height: 20),

            if (audioUrl.isNotEmpty)
              AyahAudioPlayer(
                audioUrl: audioUrl,
                audioCubit: audioCubit,
              ),
          ],
        ),
      ),
    );
  }
}
