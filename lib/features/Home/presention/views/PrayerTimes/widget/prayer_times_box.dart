import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roken_raha/core/widgets/lottie_loader.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../services/adhan.dart';

class PrayerTimesBox extends StatefulWidget {
  const PrayerTimesBox({super.key});

  @override
  State<PrayerTimesBox> createState() => _PrayerTimesBoxState();
}

class _PrayerTimesBoxState extends State<PrayerTimesBox> {
  List<Map<String, String>> times = [];
  int activeIndex = -1;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
  }

  Future<void> _loadPrayerTimes() async {
    try {
      final prayerTimesMap = await getPrayerTimesFromAdhan();

      if (prayerTimesMap.isEmpty) {
        setState(() => loading = false);
        return;
      }

      final nextPrayer = PrayerTimes(
        Coordinates(0, 0), // غير مهم هنا
        DateComponents.from(DateTime.now()),
        CalculationMethod.egyptian.getParameters(),
      ).nextPrayer(); // نستخدمه لتحديد النشط فقط

      setState(() {
        times = [
          {'name': 'الفجر', 'time': _formatTime(prayerTimesMap['fajr']!)},
          {'name': 'الظهر', 'time': _formatTime(prayerTimesMap['dhuhr']!)},
          {'name': 'العصر', 'time': _formatTime(prayerTimesMap['asr']!)},
          {'name': 'المغرب', 'time': _formatTime(prayerTimesMap['maghrib']!)},
          {'name': 'العشاء', 'time': _formatTime(prayerTimesMap['isha']!)},
        ];
        activeIndex = nextPrayer != null ? _getPrayerIndex(nextPrayer) : -1;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      debugPrint('Error loading prayer times: $e');
    }
  }

  String _formatTime(DateTime time) {
    return DateFormat.jm('ar').format(time);
  }

  int _getPrayerIndex(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return 0;
      case Prayer.dhuhr:
        return 1;
      case Prayer.asr:
        return 2;
      case Prayer.maghrib:
        return 3;
      case Prayer.isha:
        return 4;
      default:
        return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child:loading ?const LottieLoader() : SizedBox(
        height: 260,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: times.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final isActive = index == activeIndex;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive ? AppColors.primaryColor : Colors.grey.shade400,
                    width: 1.5,
                  ),
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ]
                      : [],
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      times[index]['name']!,
                      style: GoogleFonts.sacramento(
                        textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: isActive ? AppColors.primaryColor : Colors.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      times[index]['time']!,
                      style: GoogleFonts.sacramento(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isActive ? AppColors.primaryColor : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
