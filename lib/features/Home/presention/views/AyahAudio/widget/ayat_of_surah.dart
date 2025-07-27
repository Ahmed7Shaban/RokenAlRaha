import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roken_raha/services/ayah_service.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/lottie_loader.dart';
import '../../../../../../cubit/ayah_cubit/ayah_cubit.dart';
import '../../../../../../cubit/ayah_cubit/ayah_state.dart';
import 'ayah_card.dart';

class AyatOfSurah extends StatelessWidget {
  final int surahNumber;
  final String surahName;

  const AyatOfSurah({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surahName, style: AppTextStyles.appBarTitleStyle),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5E17EB), Color(0xFF3A0CA3)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.pureWhite),
        toolbarHeight: 100,
        elevation: 12,
        shadowColor: AppColors.primaryColor,
      ),
      body: BlocProvider(
        create: (_) => AyahCubit(AyahService())..fetchAyahsBySurahNumber(surahNumber),
        child: BlocBuilder<AyahCubit, AyahState>(
          builder: (context, state) {
            if (state is AyahLoading) {
              return const LottieLoader();
            } else if (state is AyahLoaded) {
              final ayat = state.ayahList;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                itemCount: ayat.length,
                itemBuilder: (context, index) {
                  final ayah = ayat[index];
                  return AyahCard(
                    ayahNumber: ayah.numberInSurah,
                    ayahText: ayah.text,
                    audioUrl: ayah.audio ?? '', // تأكد إنه مش null
                  );
                },
              );
            } else if (state is AyahError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    state.message,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return const SizedBox(); // حالة مبدئية فاضية
          },
        ),
      ),
    );
  }
}
