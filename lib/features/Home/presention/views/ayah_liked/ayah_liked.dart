import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routes/routes.dart';
import '../AyahAudio/cubit/audio_player_cubit.dart';
import 'widget/ayah_liked_body.dart';

class AyahLiked extends StatelessWidget {
  const AyahLiked({super.key});
  static const String routeName = Routes.AyahLiked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AudioPlayerCubit(),
        child: AyahLikedBody(),
      ),
    );
  }
}
