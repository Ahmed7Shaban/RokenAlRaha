import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../../routes/routes.dart';
import '../widgets/body_splash.dart';

class SplahView extends StatefulWidget {
  const SplahView({super.key});
  static const String routeName = Routes.splash;

  @override
  State<SplahView> createState() => _SplahViewState();
}

class _SplahViewState extends State<SplahView> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playIntroSound();
  }

  Future<void> _playIntroSound() async {
    await _player.play(AssetSource('Sounds/StartSound.mp3'));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodySplash());
  }
}
