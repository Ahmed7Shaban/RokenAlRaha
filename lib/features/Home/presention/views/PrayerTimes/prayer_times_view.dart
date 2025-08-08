import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../routes/routes.dart';
import 'cubit/prayer_background_cubit.dart';
import 'widget/prayer_times_body.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});
  static const String routeName = Routes.PrayerTimes;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrayerBackgroundCubit(),
      child: const PrayerTimesContent(),
    );
  }
}

class PrayerTimesContent extends StatelessWidget {
  const PrayerTimesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerBackgroundCubit, String>(
      builder: (context, backgroundAsset) {
        return Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                backgroundAsset,
                fit: BoxFit.cover,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: PrayerTimesBody(),
            ),
          ],
        );
      },
    );
  }
}
