import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:roken_raha/core/theme/app_colors.dart';
import 'package:roken_raha/source/app_lottie.dart';
import '../../../../../../core/ads/ad_service.dart';
import '../../../../../../storage/masbaha_storage_service.dart';
import '../../SaveMasbaha/widget/save_masbaha_button.dart';
import '../cubit/masbaha_cubit.dart';
import '../../../../../../core/widgets/count_action.dart';
import '../../../../../../core/widgets/count_text.dart';
import 'card_item.dart';
import 'timer_box.dart';

class MasbahaItemView extends StatefulWidget {
  const MasbahaItemView({super.key, required this.title});
  final String title;

  @override
  State<MasbahaItemView> createState() => _MasbahaItemViewState();
}

class _MasbahaItemViewState extends State<MasbahaItemView>
    with SingleTickerProviderStateMixin {
  bool showSpecial = false;
  bool isSaving = false;
  bool showPlusOne = false;
  CountAction? currentAction;

  late AnimationController _beadsController;
  Duration _beadsDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _beadsController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    AdService.showInterstitialAd();

    _beadsController.dispose();
    super.dispose();
  }

  void handleMilestoneAnimation() {
    setState(() => showSpecial = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => showSpecial = false);
    });
  }

  void moveOneBead() {
    final step = 0.2;
    var nextValue = _beadsController.value + step;

    // لو وصل لآخر الحركة نرجعه للبداية
    if (nextValue >= 1.0) {
      nextValue = 0.0;
    }

    _beadsController.animateTo(
      nextValue,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MasbahaCubit>().state;

    return Scaffold(
      body: BlocListener<MasbahaCubit, MasbahaState>(
        listenWhen: (previous, current) {
          if (current is MisbahaUpdated) {
            return current.count % 33 == 0 && current.count != 0;
          }
          return false;
        },
        listener: (context, state) => handleMilestoneAnimation(),
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardItem(title: widget.title)
                        .animate()
                        .fade(duration: 400.ms)
                        .slideY(begin: -0.3, duration: 400.ms),

                    (state is MisbahaUpdated
                            ? TimerBox(seconds: state.seconds)
                            : const TimerBox(seconds: 0))
                        .animate()
                        .fade(duration: 500.ms)
                        .slideY(begin: 0.3),

                    Animate(
                      effects: [
                        MoveEffect(
                          begin: const Offset(0, 40),
                          end: Offset.zero,
                          duration: 300.ms,
                          curve: Curves.easeOutCubic,
                        ),
                      ],
                      child: Lottie.asset(
                        AppLottie.beads,
                        controller: _beadsController,
                        onLoaded: (composition) {
                          _beadsDuration = composition.duration;
                          _beadsController.duration = _beadsDuration;
                        },
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CountText(
                              count: state is MisbahaUpdated
                                  ? '${state.count}'
                                  : '0',
                              action: currentAction,
                            )
                            .animate()
                            .fade(duration: 500.ms)
                            .scale(begin: const Offset(0.8, 0.8)),
                        if (showPlusOne)
                          const Text(
                                '+1',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                              .animate()
                              .moveY(begin: 0, end: -40, duration: 400.ms)
                              .fadeOut(duration: 400.ms),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        context.read<MasbahaCubit>().increment();
                        setState(() {
                          currentAction = CountAction.increase;
                          showPlusOne = true;
                        });
                        moveOneBead();
                        Future.delayed(500.ms, () {
                          if (mounted) {
                            setState(() => showPlusOne = false);
                          }
                        });
                      },
                      child:
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(
                                    0.4,
                                  ),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.touch_app,
                              color: Colors.white,
                              size: 35,
                            ),
                          ).animate().scale(
                            duration: 150.ms,
                            curve: Curves.easeOut,
                          ),
                    ),

                    SaveMasbahaButton(
                      isSaving: isSaving,
                      onPressed: () async {
                        AdService.showInterstitialAd();

                        setState(() => isSaving = true);
                        final currentState = context.read<MasbahaCubit>().state;
                        final currentCount = currentState is MisbahaUpdated
                            ? currentState.count
                            : 0;
                        final currentDuration = currentState is MisbahaUpdated
                            ? Duration(seconds: currentState.seconds)
                            : Duration.zero;

                        await MasbahaStorageService().saveMasbaha(
                          title: widget.title,
                          count: currentCount,
                          duration: currentDuration,
                        );

                        setState(() => isSaving = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(
                              child: Lottie.asset(
                                AppLottie.Saved,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: AppColors.primaryColor,
                          ),
                        );
                      },
                    ).animate().fade(duration: 400.ms).slideY(begin: 0.3),
                  ],
                ),
              ),
            ),

            if (showSpecial)
              Container(
                color: Colors.black.withOpacity(0.6),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      AppLottie.Confetti,
                      width: 200,
                      height: 200,
                      repeat: false,
                    ),
                    const SizedBox(height: 20),
                    Lottie.asset(
                      AppLottie.levelUp,
                      width: 200,
                      height: 200,
                      repeat: false,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
