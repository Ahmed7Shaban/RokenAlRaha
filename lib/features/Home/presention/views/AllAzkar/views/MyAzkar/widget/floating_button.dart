import 'package:flutter/material.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

import 'add_zikr_bottom_sheet.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const AddZikrBottomSheet(),
        );

      },
      backgroundColor:AppColors.primaryColor,
      child: const Icon(Icons.add, color:AppColors.pureWhite),
    );
  }
}
