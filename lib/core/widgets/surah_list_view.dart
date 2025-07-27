import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roken_raha/core/widgets/surah_card.dart';

import '../../cubit/surah_cubit/surah_cubit.dart';
import '../../cubit/surah_cubit/surah_state.dart';
import 'lottie_loader.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({super.key, required this.onTap});

  final void Function(BuildContext context, int index, dynamic surah) onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahCubit, SurahState>(
      builder: (context, state) {
        if (state is SurahLoading) {
          return const LottieLoader();
        } else if (state is SurahError) {
          return Center(child: Text(state.message));
        } else if (state is SurahLoaded) {
          return ListView.builder(
            itemCount: state.surahs.length,
            itemBuilder: (context, index) {
              final surah = state.surahs[index];

              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 300 + (index * 30)),
                tween: Tween(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: SurahCard(
                  surah: surah,
                  onTap: () => onTap(context, index, surah),
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
