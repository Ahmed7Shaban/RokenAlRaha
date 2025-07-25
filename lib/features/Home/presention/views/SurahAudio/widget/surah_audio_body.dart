import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roken_raha/core/theme/app_colors.dart';
import 'package:roken_raha/features/Home/presention/views/SurahAudio/widget/surah_ayahs_with_audio_view.dart';

import '../../../../../../core/widgets/appbar_widget.dart';
import '../../../../../../core/widgets/surah_list_view.dart';
import '../../../../../../cubit/ayah_cubit/ayah_cubit.dart';
import '../../../../../../services/ayah_service.dart';

class SurahAudioBody extends StatelessWidget {
  const SurahAudioBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(title: 'استمع للقرآن'),
        Expanded(
          child: SurahListView(
            onTap: (BuildContext context, int index, surah) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => AyahCubit(AyahService()),
                    child: SurahAyahsWithAudioView(
                      surahNumber: surah.number, surahName: surah.name,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
