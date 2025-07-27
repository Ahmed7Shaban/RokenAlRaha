import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../cubit/masbaha_cubit.dart';

class BeadsProgressRow extends StatelessWidget {
  const BeadsProgressRow({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MasbahaCubit>().state;

    if (state is! MisbahaUpdated) return const SizedBox();

    final count = state.count;
    final milestonesReached = count ~/ 33;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          String lottiePath;

          if (milestonesReached > index) {
            if (count >= 132) {
              lottiePath = 'assets/lottie/StarTop.json';
            } else if (count >= 99) {
              lottiePath = 'assets/lottie/Star3.json';
            } else if (count >= 66) {
              lottiePath = 'assets/lottie/Star2.json';
            } else if (count >= 33) {
              lottiePath = 'assets/lottie/Star1.json';
            } else {
              lottiePath = 'assets/lottie/StarTop.json';
            }
          } else {
            lottiePath = 'assets/lottie/Bead.json';
          }

          return Center(
            child: Lottie.asset(
              lottiePath,
              width: 75,
              height: 75,
            ),
          );
        }),
      ),
    );
  }
}
