import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roken_raha/source/app_images.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/lottie_loader.dart';
import '../../../../../../cubit/ayah_cubit/ayah_cubit.dart';
import '../../../../../../cubit/ayah_cubit/ayah_state.dart';
import '../cubit/audio_sequence_cubit.dart';
import '../cubit/audio_sequence_state.dart';
import 'audio_player_container.dart';

class SurahAyahsWithAudioView extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const SurahAyahsWithAudioView({super.key, required this.surahNumber, required this.surahName, });

  @override
  State<SurahAyahsWithAudioView> createState() => _SurahAyahsWithAudioViewState();
}

class _SurahAyahsWithAudioViewState extends State<SurahAyahsWithAudioView> {
  @override
  void initState() {
    super.initState();
    context.read<AyahCubit>().fetchAyahsBySurahNumber(widget.surahNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        title: Text(widget.surahName, style: AppTextStyles.appBarTitleStyle),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [          const Color(0xFF261B3D),
                AppColors. primaryColor],
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
          } else if (state is AyahLoaded) {
            final ayatTexts = state.ayahList.map((a) => a.text).toList();
            final audioUrls = state.ayahList.map((a) => a.audio).toList();

            return BlocProvider(
              create: (_) => AudioSequenceCubit(audioUrls: audioUrls),
              child: BlocBuilder<AudioSequenceCubit, AudioSequenceState>(
                builder: (context, audioState) {
                  final cubit = context.read<AudioSequenceCubit>();
                  final currentIndex = audioState is AudioSequencePlaying || audioState is AudioSequencePaused
                      ? (audioState as dynamic).index
                      : -1;

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: ayatTexts.length,
                          itemBuilder: (context, index) {
                            final isCurrent = index == currentIndex;
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isCurrent ? AppColors.primaryColor.withOpacity(0.2) : Colors.white,
                                border: Border.all(
                                  color: isCurrent ? AppColors.primaryColor : Colors.grey.shade300,
                                  width: isCurrent ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SvgPicture.asset(Assets.imagesNumberAya),
                                      Text(
                                        state.ayahList[index].numberInSurah.toString(),
                                        style: AppTextStyles.ayahNumberStyle.copyWith(color: AppColors.primaryColor),
                                      ),

                                    ],
                                  ),
SizedBox(height: 10,),
                                  Text(
                                    ayatTexts[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: isCurrent ? AppColors.primaryColor : Colors.black,
                                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      BlocBuilder<AudioSequenceCubit, AudioSequenceState>(
                        builder: (context, audioState) {
                          final cubit = context.read<AudioSequenceCubit>();

                          if (audioState is AudioSequenceError) {
                            Future.microtask(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text("⚠️ حدث خطأ في التحميل. تحقق من الاتصال."),
                                  backgroundColor: Colors.redAccent,
                                  duration: const Duration(seconds: 5),
                                  action: SnackBarAction(
                                    label: "🔁 إعادة",
                                    textColor: Colors.white,
                                    onPressed: () {
                                      context.read<AudioSequenceCubit>().playSequence();
                                    },
                                  ),
                                ),
                              );
                            });
                          } else if (audioState is AudioSequenceNoConnection) {
                            Future.microtask(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("🚫 تم فقد الاتصال بالإنترنت"),
                                  backgroundColor: Colors.orange,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            });
                          }


                          return StreamBuilder<Duration>(
                            stream: cubit.positionStream,
                            builder: (context, snapshot) {
                              final position = snapshot.data ?? Duration.zero;
                              final progress = cubit.getProgressFromPosition(position);

                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: AudioPlayerContainer(
                                  isLoading: cubit.isActuallyLoading,
                                  isPlaying: audioState is AudioSequencePlaying,
                                  progress: progress,
                                  onTap: () {
                                    final state = cubit.state;

                                    if (state is AudioSequenceInitial) {
                                      print("🟢 [INITIAL] تشغيل السلسلة لأول مرة");
                                      cubit.playSequence();
                                    } else if (state is AudioSequenceCompleted) {
                                      print("🔁 [COMPLETED] إعادة تشغيل من البداية");
                                      cubit.playSequence();
                                    } else if (state is AudioSequencePlaying) {
                                      print("⏸️ [PAUSE] إيقاف مؤقت عند الآية ${state.index + 1}");
                                      cubit.togglePlayback();
                                    } else if (state is AudioSequencePaused) {
                                      print("▶️ [RESUME] استكمال التشغيل من الآية ${state.index + 1}");
                                      cubit.togglePlayback();
                                    } else {
                                      print("⚠️ [UNKNOWN STATE] الحالة الحالية غير معروفة: $state");
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),

                    ],
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("فشل في تحميل الآيات"));
          }
        },
      ),
    );
  }
}
