import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roken_raha/source/app_images.dart';

import '../../../../cubit/actionCubit/action_bottom_cubit.dart';
import '../../../../cubit/actionCubit/action_bottom_state.dart';

class ActionsButtons extends StatelessWidget {
  const ActionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionBottomCubit, ActionBottomState>(
      builder: (context, state) {
        return Row(
          children: [
            _actionButton(
              imagePath: Assets.share,
              onTap: () {
                // شارك الآية مثلاً
              },
            ),
            _actionButton(
              imagePath: state.isLiked
                  ? Assets.liked
                  :Assets.like,
              onTap: () {
                context.read<ActionBottomCubit>().toggleLike();
              },
            ),
            _actionButton(
              imagePath: state.isSaved
                  ? Assets.saved
                  : Assets.save,
              onTap: () {
                context.read<ActionBottomCubit>().toggleSave();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _actionButton({
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
