import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../cubit/daily_aya_cubit.dart';
import '../../logic/aya_storage.dart';

class AyaText extends StatelessWidget {
  const AyaText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DailyAyaCubit(AyaStorage()),
      child: BlocBuilder<DailyAyaCubit, DailyAyaState>(
        builder: (context, state) {
          if (state is DailyAyaLoading) {
            return const CircularProgressIndicator();
          } else if (state is DailyAyaLoaded) {
            return Column(
              children: [
                Text(
                  'آية قرآنية لهذا اليوم',
                  style: GoogleFonts.amiri(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.pureWhite,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  state.aya,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.amiri(
                    color: AppColors.goldenYellow,
                    fontSize: 23,
                    height: 1.8,
                  ),
                ),
              ],
            );
          } else {
            return const Text('حدث خطأ في تحميل الآية');
          }
        },
      ),
    );
  }
}
