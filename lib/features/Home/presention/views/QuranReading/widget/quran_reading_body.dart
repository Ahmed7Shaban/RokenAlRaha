import 'package:flutter/material.dart';
import 'package:roken_raha/core/theme/app_colors.dart';
import 'package:roken_raha/core/widgets/surah_card.dart';

import '../../../../../../core/widgets/appbar_widget.dart';

class QuranReadingBody extends StatelessWidget {
  const QuranReadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(title: 'اقرأ القرآن'),
        SurahCard(),
      ],
    );
  }
}
