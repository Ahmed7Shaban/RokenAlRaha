import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/container_widget.dart';
import '../../../../../../source/app_images.dart';

class CardItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CardItem({
    super.key,
    required this.title,
    this.onTap,
  });

  void _shareContent() {
    Share.share(title);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: onTap,
        child: ContainerWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
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
