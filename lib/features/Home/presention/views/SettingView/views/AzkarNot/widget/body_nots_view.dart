import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

import '../../../../../../../../core/widgets/appbar_widget.dart';
import '../../../../widgets/sub_title.dart';
import 'select_time.dart';

class BodyNotsView extends StatefulWidget {
  const BodyNotsView({super.key, required this.subTitle, required this.onTimeSelected, required this.initialTime, required this.dec});
  final String subTitle;
  final String dec;
  final DateTime initialTime;
  final void Function(DateTime time) onTimeSelected;

  @override
  State<BodyNotsView> createState() => _BodyNotsViewState();
}

class _BodyNotsViewState extends State<BodyNotsView> {
  DateTime? selectedTime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          AppbarWidget(title:"متى نذكّرك؟ "),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(child: SubTitle(subTitle: widget.subTitle)),
              ],
            ),
          ),

          const SizedBox(height: 20),
          if (selectedTime != null)
            Text(
                'الوقت المحدد: ${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')} ${selectedTime!.hour < 12 ? "صباحًا" : "مساءً"}',
                style:GoogleFonts.cairo(
                  textStyle:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
                )
            ),
          const SizedBox(height: 20),

          SelectTime(
            onTimeSelected: (DateTime time) {
              setState(() {
                selectedTime = time;
              });
              widget.onTimeSelected(time);
            },
            initialTime: widget.initialTime,
            dec: widget.dec,
          ),

        ],
      ),
    );
  }
}
