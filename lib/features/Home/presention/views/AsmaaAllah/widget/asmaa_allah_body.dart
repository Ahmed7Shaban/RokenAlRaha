import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/appbar_widget.dart';
import '../../../../../../core/widgets/lottie_loader.dart';
import '../cubit/asmaa_cubit.dart';
import '../cubit/asmaa_state.dart';
import 'name_box.dart';

class AsmaaAllahBody extends StatelessWidget {
  const AsmaaAllahBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(title: "أسماء اللّٰه الحسنى "),

        Expanded(
          child: BlocBuilder<AsmaaCubit, AsmaaState>(
            builder: (context, state) {
              if (state is AsmaaLoading) {
                return const LottieLoader();
              } else if (state is AsmaaLoaded) {
                return ListView.builder(
                  itemCount: state.asmaa.length,
                  itemBuilder: (context, index) {
                    return NameBox(model: state.asmaa[index])  .animate()
                        .fadeIn(duration: 400.ms)
                        .slideX(
                      begin: 0.3,
                      end: 0,
                      curve: Curves.easeOut,
                      duration: 300.ms,
                      delay: (index * 100).ms,
                    );
                  },
                );
              } else if (state is AsmaaError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
