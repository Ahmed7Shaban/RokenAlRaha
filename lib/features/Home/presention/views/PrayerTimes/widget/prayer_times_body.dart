import 'package:flutter/material.dart';

import '../../../../../../core/ads/widgets/banner_ad_widget.dart';
import '../../../../../../core/widgets/location_text_widget.dart';
import 'hijri_date_text.dart';
import 'prayer_times_box.dart';
import 'time_now_text.dart';

class PrayerTimesBody extends StatelessWidget {
  const PrayerTimesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          const SizedBox(height: 30),
           Center(child: LocationTextWidget()),

          const SizedBox(height: 5),
          const TimeNowText(),
          const BannerAdWidget(),

          const Spacer(),

          //const HijriDateText(),

          const SizedBox(height: 12),
          const PrayerTimesBox(),
        ],
      ),
    );
  }
}
