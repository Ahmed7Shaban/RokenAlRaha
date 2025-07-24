import 'package:flutter/material.dart';

import '../../../../../routes/routes.dart';
import 'widget/ayah_audio_body.dart';

class AyahAudioView extends StatelessWidget {
  const AyahAudioView({super.key});
  static const String routeName = Routes.ayahAudio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AyahAudioBody(),
    );
  }
}
