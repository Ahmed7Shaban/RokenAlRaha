import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/ayah_text.dart';
import '../../../../../../source/app_images.dart';
import 'ayah_action_buttons.dart';
import 'ayah_audio_player.dart';

class AyahCard extends StatelessWidget {
  final int ayahNumber;
  final String ayahText;
  final String audioUrl;

  const AyahCard({
    super.key,
    required this.ayahNumber,
    required this.ayahText,
    required this.audioUrl,
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
                const ActionsButtons(),
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
              AyahAudioPlayer(audioUrl: audioUrl),
          ],
        ),
      ),
    );
  }
}
