import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../source/app_images.dart';
import '../asmaa_name_detail_view.dart';
import '../model/asmaa_name_model.dart';

class DetailBox extends StatelessWidget {
  final String Detail;

  const DetailBox({
    super.key,
    required this.Detail,
  });

  void _shareContent() {
    Share.share(Detail);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(

        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.pureWhite, AppColors.pureWhite, AppColors.primaryColor],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.goldenYellow, width: 2),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        Detail,
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
                      child: Image(image: AssetImage(Assets.share,),width: 50,
                        height: 50,),),

                  ],
                ),
              ),
            ],
          ) .animate()
              .fadeIn(duration: 400.ms)
              .slideX(
            begin: 0.3,
            end: 0,
            curve: Curves.easeOut,
            duration: 300.ms,
          )
        ),
      ),
    );
  }
}
