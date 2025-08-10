import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'NotificationHelper/SCHEDULE_EXACT_ALARM.dart';
import 'NotificationHelper/daily_message_notification_service.dart';
import 'NotificationHelper/unified_notification_service.dart';
import 'NotificationHelper/show_welcome_notification.dart';
import 'NotificationHelper/prayer_notification_service.dart';
import 'constants.dart';
import 'core/ads/ad_service.dart';
import 'core/ads/cubit/ad_cubit.dart';
import 'cubit/ayah_cubit/ayah_cubit.dart';
import 'cubit/surah_cubit/surah_cubit.dart';
import 'features/Home/cubit/actionCubit/action_bottom_cubit.dart';
import 'features/Home/presention/views/AllAzkar/views/MyAzkar/cubit/zikr_cubit.dart';
import 'features/Home/presention/views/AllAzkar/views/MyAzkar/model/zikr_model.dart';
import 'features/Home/presention/views/SaveMasbaha/model/masbaha_model.dart';
import 'features/Home/presention/views/SettingView/views/Adhan/model/prayer_notification_model.dart';
import 'features/Home/presention/views/ayah_liked/cubit/ayah_like_cubit.dart';
import 'features/Home/presention/views/ayah_liked/model/ayah_like_model.dart';
import 'models/ayah_model.dart';
import 'models/surah_model.dart';
import 'services/adhan.dart';
import 'services/ayah_service.dart';
import 'services/surah_service.dart';
import 'generated/l10n.dart';
import 'routes/app_routes.dart';
import 'routes/routes.dart';
import 'storage/ayah_like_storage.dart';
import 'storage/prayer_notification_hive_stronge.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة المناطق الزمنية فقط بسرعة
  tz.initializeTimeZones();

  // تشغيل التطبيق مباشرة
  runApp(const MyApp());

  // باقي التهيئة الثقيلة تشتغل في الخلفية بدون انتظار
  initializeHeavyServices();
}

void initializeHeavyServices() async {
  // طلب إذن الموقع
  await requestLocationPermission();

  // تهيئة Hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(MasbahaModelAdapter());
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(ZikrModelAdapter());
  if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(SurahModelAdapter());
  if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(AyahModelAdapter());
  if (!Hive.isAdapterRegistered(4)) Hive.registerAdapter(AyahLikeModelAdapter());

  await Hive.openBox<MasbahaModel>(Masbaha);
  await Hive.openBox<ZikrModel>(azkar);
  await Hive.openBox<SurahModel>(surahs);
  await openAllCachedAyahBoxes();

  // تهيئة الإعلانات
  await MobileAds.instance.initialize();
  await AdService.init();
  AdService.loadInterstitialAd();

  await requestExactAlarmPermission();

  await DailyMessageNotificationService.init();

  await UnifiedNotificationService.init();
  await ShowWelcomeNotification();

  final prayerTimes = await getPrayerTimesFromAdhan();
  await PrayerNotificationHiveService.init();
  await PrayerNotificationService.init();
  await PrayerNotificationService.updateAllPrayerNotifications(prayerTimes);

  // يمكن إعلام الواجهة بأن التهيئة انتهت باستخدام Cubit أو Stream
}

Future<void> requestLocationPermission() async {
  var status = await Permission.location.status;
  if (!status.isGranted) {
    var result = await Permission.location.request();
    if (result.isGranted) {
      print('✅ تم منح إذن الموقع');
    } else {
      print('❌ تم رفض إذن الموقع');
      // هنا ممكن تضيف منطق للتعامل مع رفض الإذن أو إظهار رسالة
    }
  } else {
    print('✅ إذن الموقع موجود مسبقًا');
  }
}

Future<void> openAllCachedAyahBoxes() async {
  final dir = await getApplicationDocumentsDirectory();
  final allBoxes = dir.listSync();

  for (var file in allBoxes) {
    final name = file.uri.pathSegments.last;

    if (name.startsWith('$ayahs-') && name.endsWith('.hive')) {
      final boxName = name.replaceAll('.hive', '');
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox<AyahModel>(boxName);
        print('✅ فتحنا الصندوق: $boxName');
      }
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SurahCubit(SurahService())..fetchSurahs()),
        BlocProvider(create: (_) => AyahCubit(AyahService())),
        BlocProvider(create: (_) => ActionBottomCubit()),
        BlocProvider(create: (_) => ZikrCubit()..init()),
        BlocProvider(create: (_) => AyahLikeCubit()..loadLikedAyahs()),
        BlocProvider(create: (_) => AdCubit()),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: Routes.splash,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ar', 'EN'),
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
