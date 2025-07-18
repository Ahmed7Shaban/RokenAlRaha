import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roken_raha/core/widgets/surah_list_view.dart';

import '../../../../../../core/widgets/appbar_widget.dart';
import '../../../../../../core/widgets/surah_card.dart';
import '../../../../../../cubit/surah_cubit/surah_cubit.dart';
import '../../../../../../cubit/surah_cubit/surah_state.dart';

class QuranReadingBody extends StatefulWidget {
  const QuranReadingBody({super.key});

  @override
  State<QuranReadingBody> createState() => _QuranReadingBodyState();
}

class _QuranReadingBodyState extends State<QuranReadingBody> {
  // @override
  // void initState() {
  //   super.initState();
  //   // استدعاء السور عند بداية الصفحة
  //   context.read<SurahCubit>().getSurahs();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppbarWidget(title: 'اقرأ القرآن'),
        Expanded(child: SurahListView()),
      ],
    );
  }
}
