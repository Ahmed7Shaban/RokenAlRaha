import 'package:just_audio/just_audio.dart';

class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();

  factory AudioPlayerManager() => _instance;

  AudioPlayerManager._internal();

  AudioPlayer? _currentPlayer;

  void setActivePlayer(AudioPlayer player) {
    if (_currentPlayer != null && _currentPlayer != player) {
      _currentPlayer!.stop();
      _currentPlayer!.dispose(); // تنظيف اللاعب السابق
    }
    _currentPlayer = player;
  }

  void clearPlayer(AudioPlayer player) {
    if (_currentPlayer == player) {
      _currentPlayer = null;
    }
  }

  void stopCurrentPlayer() {
    _currentPlayer?.stop();
  }

  void disposeCurrentPlayer() {
    _currentPlayer?.dispose();
    _currentPlayer = null;
  }

  bool isActive(AudioPlayer player) {
    return _currentPlayer == player;
  }

  bool get hasActivePlayer => _currentPlayer != null;
}
