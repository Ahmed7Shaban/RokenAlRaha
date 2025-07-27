import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:roken_raha/core/theme/app_colors.dart';
import 'package:roken_raha/core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/empty_list.dart';
import '../model/masbaha_model.dart';
import '../widget/masbaha_item.dart';
import 'slide_fade_transition.dart';

class SaveMasbahaBody extends StatefulWidget {
  const SaveMasbahaBody({super.key});

  @override
  State<SaveMasbahaBody> createState() => _SaveMasbahaBodyState();
}

class _SaveMasbahaBodyState extends State<SaveMasbahaBody> {
  late Box<MasbahaModel> masbahaBox;
  bool isSelecting = false;
  Set<int> selectedIndexes = {};

  @override
  void initState() {
    super.initState();
    masbahaBox = Hive.box<MasbahaModel>('masbahaBox');
  }

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
    });
  }

  void deleteSelectedItems() {
    final sortedIndexes = selectedIndexes.toList()..sort((a, b) => b.compareTo(a));
    for (var index in sortedIndexes) {
      if (index < masbahaBox.length) {
        masbahaBox.deleteAt(index);
      }
    }
    setState(() {
      selectedIndexes.clear();
      isSelecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = masbahaBox.values.toList().reversed.toList();
    final originalIndexes = List.generate(masbahaBox.length, (i) => i).reversed.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: isSelecting ? Colors.red[700] : AppColors.primaryColor,
        title: Text(isSelecting
            ? "تم تحديد ${selectedIndexes.length}"
            : "تسبيحاتي واستغفراتي" , style: AppTextStyles.appBarTitleStyle.copyWith(fontSize: 25),),
        toolbarHeight: 130,
        actions: [
          if (isSelecting)

      GestureDetector(
      onTap: deleteSelectedItems,
      child:Lottie.asset(
        'assets/lottie/select.json',
        width: 100,
        height: 100,
      ),
    )

    else
            GestureDetector(
              onTap: (){
                setState(() => isSelecting = true);
              },
              child: Lottie.asset(
                'assets/lottie/DeleteIcon.json',
                width: 100,
                height: 100,
                // fit: BoxFit.contain,
              ),
            )
        ],
      ),
      body: items.isEmpty
          ?  EmptyList()

          :ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final formattedDuration = _formatDuration(item.duration);
          final formattedDate =
          DateFormat('yyyy/MM/dd –hh:mma').format(item.date);
          final originalIndex = originalIndexes[index];
          final isSelected = selectedIndexes.contains(originalIndex);

          return SlideFadeTransition(
            index: index,
            child: GestureDetector(
              onLongPress: () {
                setState(() {
                  isSelecting = true;
                  selectedIndexes.add(originalIndex);
                });
              },
              onTap: () {
                if (isSelecting) {
                  toggleSelection(originalIndex);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.red : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: MasbahaItem(
                    title: item.title,
                    count: item.count,
                    duration: formattedDuration,
                    date: formattedDate,
                  ),
                ),
              ),
            ),
          );
        },
      ),

    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    if (minutes > 0) {
      return '$minutes دقيقة و $seconds ثانية';
    } else {
      return '$seconds ثانية';
    }
  }
}
