import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:roken_raha/core/theme/app_colors.dart';
import '../../../../../../storage/masbaha_storage_service.dart';
import '../../SaveMasbaha/widget/save_masbaha_button.dart';
import '../cubit/masbaha_cubit.dart';
import 'action_row.dart';
import 'beads_progress_row.dart';
import 'card_item.dart';
import '../../../../../../core/widgets/count_action.dart';
import '../../../../../../core/widgets/count_text.dart';
import 'timer_box.dart';


class MasbahaItemView extends StatefulWidget {
  const MasbahaItemView({super.key, required this.title});
  final String title;

  @override
  State<MasbahaItemView> createState() => _MasbahaItemViewState();
}

class _MasbahaItemViewState extends State<MasbahaItemView> {
  bool showSpecial = false;
  bool isSaving = false;
  CountAction? currentAction;

  void handleMilestoneAnimation() {
    setState(() => showSpecial = true);
    Future.delayed(const Duration(seconds: 5), () {
      setState(() => showSpecial = false);
    });
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CardItem(title: widget.title)
                      .animate()
                      .fade(duration: 400.ms)
                      .slideY(begin: -0.3, duration: 400.ms),

                  const BeadsProgressRow()
                      .animate()
                      .fade(duration: 500.ms)
                      .slideX(begin: -0.3),

                  const SizedBox(height: 5),

                  (state is MisbahaUpdated
                      ? TimerBox(seconds: state.seconds)
                      : const TimerBox(seconds: 0))
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(begin: 0.3),

                  CountText(
                    count: state is MisbahaUpdated ? '${state.count}' : '0',
                    action: currentAction,
                  )
                      .animate()
                      .fade(duration: 500.ms)
                      .scale(begin: const Offset(0.8, 0.8)),

                  Center(
                    child: Lottie.asset(
                      showSpecial
                          ? 'assets/lottie/levelUp.json'
                          : 'assets/lottie/Bead.json',
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  )
                      .animate()
                      .fade(duration: 600.ms)
                      .slideY(begin: 0.4),

                  ActionRow(
                    onIncrease: () {
                      context.read<MasbahaCubit>().increment();
                      setState(() => currentAction = CountAction.increase);
                    },
                    onDecrease: () {
                      context.read<MasbahaCubit>().decrement();
                      setState(() => currentAction = CountAction.decrease);
                    },
                    onReset: () {
                      context.read<MasbahaCubit>().reset();
                      setState(() => currentAction = CountAction.reset);

                    },
                  )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(begin: 0.2),

                  const SizedBox(height: 10),

                  SaveMasbahaButton(
                    isSaving: isSaving,
                    onPressed: () async {
                      setState(() => isSaving = true);
                      final currentState = context.read<MasbahaCubit>().state;
                      final currentCount =
                      currentState is MisbahaUpdated ? currentState.count : 0;
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
                              'assets/lottie/Saved.json',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: AppColors.primaryColor,
                        ),
                      );
                    },
                  )
                      .animate()
                      .fade(duration: 400.ms)
                      .slideY(begin: 0.3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
