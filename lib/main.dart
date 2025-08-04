import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'cubit/ayah_cubit/ayah_cubit.dart';
import 'cubit/surah_cubit/surah_cubit.dart';
import 'features/Home/cubit/actionCubit/action_bottom_cubit.dart';
import 'features/Home/presention/views/AllAzkar/views/MyAzkar/cubit/zikr_cubit.dart';
import 'features/Home/presention/views/AllAzkar/views/MyAzkar/model/zikr_model.dart';
import 'features/Home/presention/views/SaveMasbaha/model/masbaha_model.dart';
import 'models/ayah_model.dart';
import 'models/surah_model.dart';
import 'services/ayah_service.dart';
import 'services/surah_service.dart';
import 'generated/l10n.dart';
import 'routes/app_routes.dart';
import 'routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // تسجيل الـ Adapters
  if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(MasbahaModelAdapter());
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(ZikrModelAdapter());
  if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(SurahModelAdapter());
  if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(AyahModelAdapter());
  //await Hive.deleteBoxFromDisk('ayahsBox');

  // فتح الصناديق
  await Hive.openBox<MasbahaModel>('MasbahaBox');
  await Hive.openBox<ZikrModel>('azkarBox');
  await Hive.openBox<SurahModel>('surahsBox');
 // await Hive.openBox<AyahModel>('ayahsBox');
  //clearOldHiveAyahBoxes();

  await openAllCachedAyahBoxes();
  runApp(MyApp());
}

Future<void> clearOldHiveAyahBoxes() async {
  for (int i = 1; i <= 114; i++) {
    final boxName = 'ayahsBox-$i';
    if (await Hive.boxExists(boxName)) {
      print("🗑️ حذف $boxName");
      await Hive.deleteBoxFromDisk(boxName);
    }
  }
}

Future<void> openAllCachedAyahBoxes() async {
  final dir = await getApplicationDocumentsDirectory();
  final allBoxes = dir.listSync();

  for (var file in allBoxes) {
    final name = file.uri.pathSegments.last;

    // نفتش على كل صندوق اسمه يبدأ بـ ayahsBox-
    if (name.startsWith('ayahsBox-') && name.endsWith('.hive')) {
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
