import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../source/app_images.dart';
import '../../../cubit/dynamic_content_cubit .dart';
import '../../../cubit/dynamic_content_state.dart';
import '../../../date/content_box_list.dart';

class DynamicContentBox extends StatelessWidget {
  const DynamicContentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DynamicContentCubit(length: ContentBoxList.length),
      child: BlocBuilder<DynamicContentCubit, DynamicContentState>(
        builder: (context, state) {
          final currentItem = ContentBoxList[state.currentIndex];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(18),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Assets.imagesMotivasi),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book,
                              color: AppColors.goldenYellow,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              currentItem["title"] ?? '',
                              style: AppTextStyles.contentTitle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentItem["text"] ?? '',
                          style: AppTextStyles.contentText,
                          maxLines: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
