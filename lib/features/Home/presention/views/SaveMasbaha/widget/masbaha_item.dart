import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/container_widget.dart';
import '../../../../../../source/app_images.dart';

class MasbahaItem extends StatelessWidget {
  final String title;
  final int count;
  final String duration;
  final String date;

  const MasbahaItem({
    super.key,
    required this.title,
    required this.count,
    required this.duration,
    required this.date,
  });

  void _shareContent() {
    Share.share('$title\nالتكرار: $count\nالمدة: $duration\nالتاريخ: $date');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ContainerWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.titleStyle.copyWith(
                        fontSize: 24,
                        shadows: const [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _shareContent,
                    child: Image.asset(
                      Assets.share,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: _infoItem('العدد', '$count')),
                  Flexible(child: _infoItem('المدة', duration)),
                  Flexible(child: _infoItem('التاريخ', date)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 4),
        AutoSizeText(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
