// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hijri/hijri_calendar.dart';
//
// class HijriDateText extends StatelessWidget {
//   const HijriDateText({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     HijriCalendar.setLocal("ar");
//
//     final hijri = HijriCalendar.now();
//     hijri.hijriAdjust = -1; // إنقاص يوم واحد (مهم جداً)
//
//     final dayName = _getArabicWeekDayName(hijri.weekDay());
//     final hijriDate = '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} هـ';
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             dayName,
//             style: GoogleFonts.cairo(
//               textStyle: const TextStyle(
//                 fontSize: 26,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             hijriDate,
//             style: GoogleFonts.cairo(
//               textStyle: const TextStyle(
//                 fontSize: 22,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _getArabicWeekDayName(int weekDayNumber) {
//     const arabicDays = [
//       'السبت',
//       'الأحد',
//       'الإثنين',
//       'الثلاثاء',
//       'الأربعاء',
//       'الخميس',
//       'الجمعة',
//     ];
//     return arabicDays[weekDayNumber % 7];
//   }
// }
