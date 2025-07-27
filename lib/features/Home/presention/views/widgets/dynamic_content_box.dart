import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/content_box.dart';
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

          return ContentBox(title:  currentItem["title"] ?? '', text: currentItem["text"] ?? '');
        },
      ),
    );
  }
}
