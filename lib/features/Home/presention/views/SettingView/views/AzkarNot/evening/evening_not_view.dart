import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roken_raha/core/widgets/lottie_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../../NotificationHelper/daily_notification_service.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../routes/routes.dart';
import '../../../../AllAzkar/date/evening_list.dart';
import '../widget/body_nots_view.dart';

class EveningNotView extends StatelessWidget {
  const EveningNotView({super.key});
  static const String routeName = Routes.EveningNot;

  Future<DateTime> _getStoredTimeOrNow() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTime = prefs.getString('evening_notification_time');

    if (storedTime != null) {
      final parts = storedTime.split(':');
      final hour = int.tryParse(parts[0]) ?? 18;
      final minute = int.tryParse(parts[1]) ?? 0;
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, hour, minute);
    } else {
      return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    final DailyMessageNotificationService notificationService =
    DailyMessageNotificationService(messages: eveningAzkar);

    return Scaffold(
      body: FutureBuilder<DateTime>(
        future: _getStoredTimeOrNow(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LottieLoader();

          return Column(
            children: [
              Expanded(
                child: BodyNotsView(
                  subTitle: 'متى تحب أن يصلك إشعار أذكار المساء؟',
                  initialTime: snapshot.data!,
                  onTimeSelected: (DateTime selectedDateTime) async {
                    final selectedTime = TimeOfDay.fromDateTime(selectedDateTime);

                    if (selectedTime.hour < 12) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'من فضلك اختر وقتًا مسائيًا بعد الساعة 12 ظهرًا.',
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    final prefs = await SharedPreferences.getInstance();
                    final storedTime =
                        '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}';
                    await prefs.setString('evening_notification_time', storedTime);

                    await notificationService.init();
                    await notificationService.scheduleDailyNotificationFromStoredTime();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'تم تعيين تذكير أذكار المساء بنجاح 🌙',
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
