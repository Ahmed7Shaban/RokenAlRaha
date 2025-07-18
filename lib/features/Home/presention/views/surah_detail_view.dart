// lib/features/Home/presentation/views/surah_detail_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../cubit/ayah_cubit/ayah_cubit.dart';
import '../../../../cubit/ayah_cubit/ayah_state.dart';
import '../../../../models/surah_model.dart';

class SurahDetailView extends StatefulWidget {
  final int surahIndex;
  final SurahModel surah;

  const SurahDetailView({
    super.key,
    required this.surahIndex,
    required this.surah,
  });

  @override
  State<SurahDetailView> createState() => _SurahDetailViewState();
}

class _SurahDetailViewState extends State<SurahDetailView> {
  @override
  void initState() {
    super.initState();
    context.read<AyahCubit>().fetchAyahs(widget.surahIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.surah.name,
          style: AppTextStyles.appBarTitleStyle,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5E17EB),
                Color(0xFF3A0CA3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.pureWhite),
        toolbarHeight: 100,
        elevation: 12,
        shadowColor: AppColors.primaryColor,
      ),
      body: BlocBuilder<AyahCubit, AyahState>(
        builder: (context, state) {
          if (state is AyahLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is AyahError) {
            return Center(
              child: Text(state.message, style: TextStyle(color: AppColors.primaryColor)),
            );
          } else if (state is AyahLoaded) {
            final ayahs = state.ayahs;
            final fullText = ayahs
                .map((ayah) => "${ayah.text} ﴿${ayah.numberInSurah}﴾")
                .join(" ");

            return Stack(
              children: [
                // الظلال الجانبية
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black12, Colors.transparent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black12, Colors.transparent],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Text(
                    fullText,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.amiri(
                      fontSize: 24,
                      color: Colors.black,
                      height: 2.3,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),

                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
