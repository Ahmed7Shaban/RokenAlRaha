import 'package:just_audio/just_audio.dart';

class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();

  factory AudioPlayerManager() => _instance;

  AudioPlayerManager._internal();

  AudioPlayer? _currentPlayer;

  void setActivePlayer(AudioPlayer player) {
    if (_currentPlayer != null && _currentPlayer != player) {
      _currentPlayer!.stop(); // نوقف القديم
    }
    _currentPlayer = player;
  }

  void clearPlayer(AudioPlayer player) {
    if (_currentPlayer == player) {
      _currentPlayer = null;
    }
  }
}
