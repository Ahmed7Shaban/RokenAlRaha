import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cubit/ayah_cubit/ayah_cubit.dart';
import 'cubit/surah_cubit/surah_cubit.dart';
import 'services/ayah_service.dart';
import 'services/surah_service.dart';
import 'generated/l10n.dart';
import 'routes/app_routes.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SurahCubit(SurahService())..fetchSurahs()),
        BlocProvider(
          create: (_) => AyahCubit(AyahService()),
        ), // BlocProvider(create: (_) => AnotherCubit()),
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
