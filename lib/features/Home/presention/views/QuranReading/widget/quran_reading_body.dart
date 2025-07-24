import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roken_raha/core/theme/app_colors.dart';
import 'package:roken_raha/core/widgets/surah_card.dart';

import '../../../../../../core/widgets/appbar_widget.dart';
import '../../../../../../core/widgets/surah_list_view.dart';
import '../../../../../../cubit/ayah_cubit/ayah_cubit.dart';
import 'surah_detail_view.dart';

class QuranReadingBody extends StatelessWidget {
  const QuranReadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(title: 'اقرأ القرآن'),

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
