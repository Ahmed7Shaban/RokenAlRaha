// lib/views/surah_list_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/widgets/surah_card.dart';
import '../../cubit/surah_cubit/surah_cubit.dart';
import '../../cubit/surah_cubit/surah_state.dart';
import '../../features/Home/presention/views/surah_detail_view.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahCubit, SurahState>(
      builder: (context, state) {
        if (state is SurahLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SurahError) {
          return Center(child: Text(state.message));
        } else if (state is SurahLoaded) {
          return ListView.builder(
            itemCount: state.surahs.length,
            itemBuilder: (context, index) {
              final surah = state.surahs[index];
              return SurahCard(
                surah: surah,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          SurahDetailView(surahIndex: index, surah: surah),
                    ),
                  );
                },
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
