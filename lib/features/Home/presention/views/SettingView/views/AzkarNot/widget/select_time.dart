import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../core/theme/app_colors.dart';

class SelectTime extends StatefulWidget {
  final void Function(DateTime time) onTimeSelected;
  final DateTime initialTime;

  const SelectTime({
    super.key,
    required this.onTimeSelected,
    required this.initialTime,
  });

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  late DateTime selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime; // الوقت اللي اتحدد أول مرة
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'اختر وقت الإشعار الصباحي',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          TimePickerSpinner(
            is24HourMode: false,
            isShowSeconds: false,
            isForce2Digits: false,
            normalTextStyle: const TextStyle(fontSize: 24, color: Colors.grey),
            highlightedTextStyle: GoogleFonts.cairo(
              textStyle: TextStyle(
                fontSize: 28,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            spacing: 30,
            itemHeight: 60,
            minutesInterval: 1,
            time: selectedTime,
            onTimeChange: (time) {
              setState(() => selectedTime = time);
              widget.onTimeSelected(time);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'مسموح من 5:00 إلى 11:59 صباحًا فقط',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
