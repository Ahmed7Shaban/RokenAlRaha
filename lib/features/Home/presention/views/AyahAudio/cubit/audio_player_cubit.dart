import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  static final AudioPlayer _player = AudioPlayer();
  String? _currentUrl;
  StreamSubscription<Duration>? _progressSubscription;

  // ✅ Getter لحالة الصوت الحالي
  String? get currentUrl => _currentUrl;

  AudioPlayerCubit() : super(AudioPlayerInitial()) {
    print("🟡 AudioPlayerCubit initialized");

    // ✅ استماع لحالة انتهاء الصوت
    _player.playerStateStream.listen((playerState) {
      final isCompleted = playerState.processingState == ProcessingState.completed;
      final isPlaying = playerState.playing;

      print("🎯 playerState changed → playing: $isPlaying, completed: $isCompleted, state: ${playerState.processingState}");

      if (isCompleted && !isPlaying) {
        print("✅ AudioPlayerCompleted");
        emit(AudioPlayerCompleted());
        emit(AudioPlayerProgress(0.0)); // رجّع الشريط للصفر
      }
    });

    // ✅ استماع لتقدّم الصوت
    _progressSubscription = _player.positionStream.listen((position) {
      final duration = _player.duration ?? Duration.zero;

      print("📍 positionStream updated → position: $position / duration: $duration");

      if (duration.inMilliseconds > 0) {
        final progress = position.inMilliseconds / duration.inMilliseconds;
        print("⏱️ Progress Emitted: $progress");
        emit(AudioPlayerProgress(progress));
      }
    });
  }

  // ✅ تشغيل أو إيقاف الصوت
  Future<void> togglePlay(String url) async {
    print("🚀 togglePlay triggered with URL: $url");

    if (_currentUrl == url && _player.playing) {
      print("⏸️ Pausing current audio");
      await _player.pause();
      emit(AudioPlayerPaused());
    } else {
      try {
        emit(AudioPlayerLoading());
        print("🔄 Loading audio: $url");

        if (_currentUrl != url) {
          print("📦 New audio detected. Setting URL...");
          _currentUrl = url;
          await _player.setUrl(url);
        }

        await _player.play();
        emit(AudioPlayerPlaying());
        print("▶️ AudioPlayerPlaying");
      } catch (e) {
        print("❌ AudioPlayerError: $e");
        emit(AudioPlayerError("حدث خطأ أثناء تشغيل الصوت"));
      }
    }
  }

  @override
  Future<void> close() {
    print("🧹 AudioPlayerCubit disposed");
    _progressSubscription?.cancel();
    _player.dispose();
    return super.close();
  }
}
