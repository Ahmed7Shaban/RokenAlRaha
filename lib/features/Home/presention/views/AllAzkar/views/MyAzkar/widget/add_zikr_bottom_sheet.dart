import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../cubit/zikr_cubit.dart';
import '../model/zikr_model.dart';
import 'success_dialog.dart';
import 'zikr_text_field.dart'; // استيراد ويدجت الحقول

class AddZikrBottomSheet extends StatefulWidget {
  const AddZikrBottomSheet({super.key});

  @override
  State<AddZikrBottomSheet> createState() => _AddZikrBottomSheetState();
}

class _AddZikrBottomSheetState extends State<AddZikrBottomSheet> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  int _count = 1;

  void _save() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Animate().shake();
      return;
    }

    final zikr = ZikrModel(title: title, content: content, count: _count);
    context.read<ZikrCubit>().addZikr(zikr);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SuccessDialog(),
    );

    await Future.delayed(const Duration(milliseconds: 900));
    if (mounted) {
      Navigator.of(context).pop(); // Close Dialog
      Navigator.of(context).pop(); // Close BottomSheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🟢 عنوان الذكر
                ZikrTextField(
                  controller: _titleController,
                  label: 'عنوان الذكر',
                  icon: Icons.title,
                ),
                const SizedBox(height: 15),

                // 🟢 نص الذكر
                ZikrTextField(
                  controller: _contentController,
                  label: 'نص الذكر',
                  icon: Icons.notes,
                  maxLines: 3,
                ),
                const SizedBox(height: 15),

                // 🟢 عداد التكرار
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: AppColors.primaryColor ,),
                      onPressed: () {
                        if (_count > 1) {
                          setState(() => _count--);
                        }
                      },
                    ),
                    Text(
                      '$_count',
                      style: const TextStyle(
                        fontSize: 22,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon:  Icon(Icons.add_circle, color: AppColors.primaryColor),
                      onPressed: () {
                        setState(() => _count++);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 🟢 زر الحفظ
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _save,
                    icon: const Icon(Icons.save,color:AppColors.pureWhite),
                    label:  Text(
                      'حفظ الذكر',
                      style: TextStyle(fontSize: 16,color:AppColors.pureWhite),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
