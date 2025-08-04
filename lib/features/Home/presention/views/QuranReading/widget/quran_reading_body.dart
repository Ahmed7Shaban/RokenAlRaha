import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roken_raha/core/widgets/appbar_widget.dart';
import 'package:roken_raha/core/widgets/surah_list_view.dart';
import 'package:roken_raha/cubit/ayah_cubit/ayah_cubit.dart';
import 'package:roken_raha/features/Home/presention/views/QuranReading/widget/surah_detail_view.dart';

class QuranReadingBody extends StatelessWidget {
  const QuranReadingBody({super.key});

  Future<void> _navigateToSavedAyah(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final savedSurah = prefs.getInt('sav_surah_number');
    final savedAyah = prefs.getInt('sav_ayah_number');
    final surahName = prefs.getString('saved_surah_name') ?? 'سورة';

    if (savedSurah != null && savedAyah != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<AyahCubit>(context),
            child: SurahDetailView(
              surahNumber: savedSurah,
              initialAyahNumber: savedAyah,
              surahName: surahName,
            ),

          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("لا توجد آية محفوظة")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(
          title: 'اقرأ القرآن',
          showActions: true,
          onTapSaved: () => _navigateToSavedAyah(context),
        ),
        Expanded(
          child: SurahListView(
            onTap: (BuildContext context, int index, surah) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<AyahCubit>(context),
                    child: SurahDetailView(surah: surah),
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
