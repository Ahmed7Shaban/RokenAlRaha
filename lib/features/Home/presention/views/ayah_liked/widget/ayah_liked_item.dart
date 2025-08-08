import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../../../source/app_images.dart';
import '../../../../../../core/widgets/container_widget.dart';
import '../../AyahAudio/cubit/audio_player_cubit.dart';
import '../../AyahAudio/widget/ayah_audio_player.dart';
import '../model/ayah_like_model.dart';

class AyahLikedItem extends StatelessWidget {
  final AyahLikeModel ayahLikeModel;
  final VoidCallback? onDeleted;

  const AyahLikedItem({super.key, required this.ayahLikeModel, this.onDeleted});

  void _shareContent() {
    Share.share("${ayahLikeModel.surahName}\n\n${ayahLikeModel.ayahText}");
  }

  @override
  Widget build(BuildContext context) {
    final audioCubit = context.read<AudioPlayerCubit>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Dismissible(
        key: ValueKey(ayahLikeModel.key),
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
        onDismissed: (_) {
          if (onDeleted != null) onDeleted!();
        },
        child: ContainerWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(

                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(Assets.imagesNumberAya,width: 50,),
                        Text(
                          "${ayahLikeModel.ayahNumber}",
                          style: AppTextStyles.titleStyle.copyWith(
                            fontSize: 25,
                          ),
                        ),
                        ]
                          ),

                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              ayahLikeModel.ayahText,
                              style: AppTextStyles.titleStyle.copyWith(
                                fontSize: 30,
                                color: Colors.black
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _shareContent,
                      child: Image.asset(Assets.share, width: 40, height: 40),
                    ),
                  ],
                ),
              ),

              Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  ayahLikeModel.surahName,
                  style: AppTextStyles.titleStyle.copyWith(fontSize: 30),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: BlocProvider.value(
                  value: audioCubit,
                  child: AyahAudioPlayer(
                    audioUrl: ayahLikeModel.audioUrl,
                    audioCubit: audioCubit,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
