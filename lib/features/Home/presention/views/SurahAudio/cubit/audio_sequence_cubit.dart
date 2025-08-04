import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_sequence_state.dart';

class AudioSequenceCubit extends Cubit<AudioSequenceState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> audioUrls;

  int _currentIndex = 0;
  bool isActuallyLoading = false;
  bool _hasShownSnackBar = false;
  bool _hasStartedPlayback = false; // ✅ جديد
  StreamSubscription? _connectivitySubscription;

  AudioSequenceCubit({required this.audioUrls}) : super(AudioSequenceInitial()) {
    print("🎧 AudioSequenceCubit initialized with ${audioUrls.length} URLs");

    _audioPlayer.playerStateStream.listen((state) async {
      print("📻 Player State Changed: ${state.processingState}");

      final isLoadingNow = state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering;

      if (isLoadingNow != isActuallyLoading) {
        isActuallyLoading = isLoadingNow;
        emit(stateUpdate());
      }

      if (state.processingState == ProcessingState.completed) {
        print("⏭️ Current audio completed. Moving to next...");
        await _playNext();
      }

      if (state.processingState == ProcessingState.idle) {
        print("❌ Idle State: Possible error or network issue");

        // ✅ لا تظهر السناك بار إلا بعد بدء التشغيل فعليًا
        if (_hasStartedPlayback && !_hasShownSnackBar) {
          _hasShownSnackBar = true;
          emit(AudioSequenceError());
        }
      }
    });
  }

  Future<void> playSequence() async {
    if (audioUrls.isEmpty) {
      print("⚠️ No audio URLs provided!");
      return;
    }

    print("▶️ Starting sequence playback...");
    _hasShownSnackBar = false;
    _hasStartedPlayback = true; // ✅ تم بدء التشغيل
    emit(AudioSequenceLoading());

    _currentIndex = 0;
    await _playCurrent();
  }

  Future<void> _playCurrent() async {
    try {
      final url = audioUrls[_currentIndex];
      print("🎼 Playing index $_currentIndex => $url");
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
      print("✅ Playback started for index $_currentIndex");
      emit(AudioSequencePlaying(index: _currentIndex));
    } catch (e) {
      print("❌ Error playing audio at index $_currentIndex: $e");
      if (!_hasShownSnackBar) {
        _hasShownSnackBar = true;
        emit(AudioSequenceError());
      }
    }
  }

  Future<void> _retryCurrent() async {
    print("🔁 Retrying current audio...");
    _hasShownSnackBar = false;
    emit(AudioSequenceLoading());
    await _playCurrent();
  }

  Future<void> _playNext() async {
    _currentIndex++;
    if (_currentIndex < audioUrls.length) {
      print("➡️ Moving to index $_currentIndex");
      await _playCurrent();
    } else {
      print("🏁 All audios played. Sequence complete.");
      _hasStartedPlayback = false; // ✅ تم الانتهاء من التشغيل
      emit(AudioSequenceCompleted());
    }
  }

  void togglePlayback() async {
    if (_audioPlayer.playing) {
      print("⏸️ Pausing audio at index $_currentIndex");
      await _audioPlayer.pause();
      emit(AudioSequencePaused(index: _currentIndex));
    } else {
      print("▶️ Resuming audio at index $_currentIndex");
      await _audioPlayer.play();
      emit(AudioSequencePlaying(index: _currentIndex));
    }
  }

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  double getProgressFromPosition(Duration position) {
    final duration = _audioPlayer.duration?.inMilliseconds ?? 1;
    final progress = (position.inMilliseconds / duration).clamp(0.0, 1.0);
    print("📊 Progress Stream: ${progress.toStringAsFixed(2)}");
    return progress;
  }

  AudioSequenceState stateUpdate() {
    final current = state;

    if (current is AudioSequencePlaying) {
      return AudioSequencePlaying(index: current.index);
    } else if (current is AudioSequencePaused) {
      return AudioSequencePaused(index: current.index);
    } else if (current is AudioSequenceLoading) {
      return AudioSequenceLoading();
    } else if (current is AudioSequenceCompleted) {
      return AudioSequenceCompleted();
    } else if (current is AudioSequenceError) {
      return AudioSequenceError();
    } else {
      return AudioSequenceInitial();
    }
  }

  @override
  Future<void> close() {
    print("🧹 Disposing audio player and subscriptions...");
    _connectivitySubscription?.cancel();
    _audioPlayer.dispose();
    _hasStartedPlayback = false; // ✅ Reset عند الإغلاق
    return super.close();
  }
}
