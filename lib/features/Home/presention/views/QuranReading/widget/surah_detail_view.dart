import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/action_button.dart';
import '../../../../../../core/widgets/lottie_loader.dart';
import '../../../../../../cubit/ayah_cubit/ayah_cubit.dart';
import '../../../../../../cubit/ayah_cubit/ayah_state.dart';
import '../../../../../../models/surah_model.dart';
import '../../../../../../models/ayah_model.dart';
import '../../../../../../source/app_images.dart';

class SurahDetailView extends StatefulWidget {
  final SurahModel? surah;
  final int? surahNumber;
  final int? initialAyahNumber;
  final String? surahName;

  const SurahDetailView({
    super.key,
    this.surah,
    this.surahNumber,
    this.initialAyahNumber,
    this.surahName,
  });

  @override
  State<SurahDetailView> createState() => _SurahDetailViewState();
}

class _SurahDetailViewState extends State<SurahDetailView> {
  int? selectedAyahNumber;
  late ScrollController scrollController;
  bool _hasScrolledToInitialAyah = false;

  String get _surahName {
    return widget.surah?.name ?? widget.surahName ?? 'سورة';
  }

  int get _surahNumber {
    return widget.surah?.number ?? widget.surahNumber!;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    selectedAyahNumber = widget.initialAyahNumber;
    context.read<AyahCubit>().fetchAyahsBySurahNumber(_surahNumber);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToInitialAyah() {
    if (_hasScrolledToInitialAyah || selectedAyahNumber == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        scrollController.animateTo(
          (selectedAyahNumber! - 1) * 100.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        _hasScrolledToInitialAyah = true;
      } catch (_) {}
    });
  }

  void _selectAyah(
      BuildContext context,
      int number,
      int? selectedAyahNumber,
      Function(int?) setSelectedAyah,
      List<AyahModel> ayahs,
      ) {
    final newSelected = selectedAyahNumber == number ? null : number;
    setSelectedAyah(newSelected);

    if (newSelected == null) return;

    final ayah = ayahs[newSelected - 1];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(
              imagePath: Assets.saved,
              onTap: () async {
                Navigator.pop(context);
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt('sav_surah_number', _surahNumber);
                await prefs.setInt('sav_ayah_number', ayah.numberInSurah);
                await prefs.setString('saved_surah_name', _surahName);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم حفظ الآية")),
                  );
                }
              },
            ),
            ActionButton(
              imagePath: Assets.share,
              onTap: () {
                Navigator.pop(context);
                final text = '${ayah.text}\n- آية ${ayah.numberInSurah}';
                Share.share(text);
              },
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_surahName, style: AppTextStyles.appBarTitleStyle),
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
      body: BlocBuilder<AyahCubit, AyahState>(
        builder: (context, state) {
          if (state is AyahLoading) {
            return const LottieLoader();
          } else if (state is AyahError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            );
          } else if (state is AyahLoaded) {
            final List<AyahModel> ayahs = state.ayahList;
            _scrollToInitialAyah();

            return SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: RichText(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: ayahs.map((ayah) {
                    final isSelected =
                        selectedAyahNumber == ayah.numberInSurah;

                    return TextSpan(
                      text: '${ayah.text} ﴿${ayah.numberInSurah}﴾ ',
                      style: AppTextStyles.ayahTextStyle.copyWith(
                        backgroundColor: isSelected
                            ? Colors.yellow.withOpacity(0.3)
                            : null,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _selectAyah(
                          context,
                          ayah.numberInSurah,
                          selectedAyahNumber,
                              (val) => setState(() => selectedAyahNumber = val),
                          ayahs,
                        ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
