import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../source/app_images.dart';

class ZkarCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const ZkarCard({
    super.key,
    required this.name,
    required  this.onTap,
  });

  void _shareContent() {
    Share.share(name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.pureWhite, AppColors.primaryColor],
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
                        name,
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
          ),
        ),
      ),
    );
  }
}
