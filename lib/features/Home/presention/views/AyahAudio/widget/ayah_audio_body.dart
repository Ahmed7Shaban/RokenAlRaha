import 'package:flutter/material.dart';
import '../../../../../../core/widgets/appbar_widget.dart';
import '../../../../../../core/widgets/surah_list_view.dart';
import '../../../../../../services/ayah_service.dart';
import 'ayat_of_surah.dart';
import '../../../../../../models/ayah_model.dart';

class AyahAudioBody extends StatelessWidget {
  const AyahAudioBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppbarWidget(title: 'آيات مع التلاوة'),
        Expanded(
          child: SurahListView(
            onTap: (context, index, surah) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AyatOfSurah( surahNumber: surah.number, surahName: surah.name,),
                ),
              );
            },
          ),
        ),

      ],
    );
  }
}
