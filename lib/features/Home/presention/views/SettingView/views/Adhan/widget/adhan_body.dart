import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../../../../NotificationHelper/SCHEDULE_EXACT_ALARM.dart';
import '../../../../../../../../NotificationHelper/show_welcome_notification.dart';
import '../../../../../../../../core/ads/widgets/banner_ad_widget.dart';
import '../../../../../../../../core/widgets/appbar_widget.dart';
import '../cubit/prayer_notification_cubit.dart';
import '../model/prayer_notification_model.dart';
import 'times_box.dart';

class AdhanBody extends StatelessWidget {
  const AdhanBody({super.key});

  @override
  Widget build(BuildContext context) {
    requestExactAlarmPermission();
    return BlocProvider(
      create: (_) => PrayerNotificationCubit()..loadNotifications(),
      child: Column(
        children: [
          const AppbarWidget(title: "الاذان"),
          BannerAdWidget(),

          const Expanded(child: TimesBox()),


        ],
      ),
    );
  }
}
