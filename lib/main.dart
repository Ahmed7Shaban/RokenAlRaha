import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'cubit/ayah_cubit/ayah_cubit.dart';
import 'cubit/surah_cubit/surah_cubit.dart';
import 'features/Home/cubit/actionCubit/action_bottom_cubit.dart';
import 'features/Home/presention/views/AllAzkar/views/MyAzkar/cubit/zikr_cubit.dart';
import 'features/Home/presention/views/AllAzkar/views/MyAzkar/model/zikr_model.dart';
import 'features/Home/presention/views/SaveMasbaha/model/masbaha_model.dart';
import 'services/ayah_service.dart';
import 'services/surah_service.dart';
import 'generated/l10n.dart';
import 'routes/app_routes.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();


  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(MasbahaModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(ZikrModelAdapter());
  }
  print("quranBox");
  await Hive.openBox('quranBox');
 print("MasbahaBox");
  await Hive.openBox<MasbahaModel>('MasbahaBox');
  print("azkarBox");
  await Hive.openBox<ZikrModel>('azkarBox');
  // 🧹 مسح الكاش مؤقتًا لحل مشكلة النوع
  // await Hive.box('quranBox').clear();
// print("🧹 تم مسح الكاش بالكامل");


  runApp(MyApp());
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
        locale: const Locale('ar', 'en'),
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
