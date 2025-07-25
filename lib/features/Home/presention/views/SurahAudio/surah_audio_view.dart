import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

import '../../../../../cubit/ayah_cubit/ayah_cubit.dart';
import '../../../../../routes/routes.dart';
import '../../../../../services/ayah_service.dart';
import 'widget/surah_audio_body.dart';

class SurahAudioView extends StatelessWidget {
  const SurahAudioView({super.key});
  static const String routeName = Routes.surahAudio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: BlocProvider(
        create: (_) => AyahCubit(AyahService()),
        child: SurahAudioBody(),
      )

    );
  }
}
