import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _player = AudioPlayer();
  String? currentUrl;

  AudioPlayerCubit() : super(AudioPlayerInitial()) {
    _player.playerStateStream.listen(_handlePlayerState);
    _player.positionStream.listen(_handlePositionStream);
    print('[INIT] AudioPlayerCubit initialized');
  }

  // Getters
  bool get isPlaying => state is AudioPlayerPlaying;
  bool get isLoading => state is AudioPlayerLoading;

  Future<void> togglePlay(String url) async {
    try {
      print('[TOGGLE PLAY] Requested URL: $url');
      // لو بيشغل نفس الصوت، اعمل Pause
      if (isPlaying && currentUrl == url) {
        print('[ACTION] Pausing current audio');
        await _player.pause();
        emit(AudioPlayerPaused());
        print('[STATE] AudioPlayerPaused');
        return;
      }

      // لو كان صوت مختلف، حمله من جديد
      currentUrl = url;
      emit(AudioPlayerLoading());
      print('[STATE] AudioPlayerLoading');

      await _player.setUrl(url);
      print('[AUDIO] URL set successfully');

      await _player.play();
      emit(AudioPlayerPlaying(url));
      print('[STATE] AudioPlayerPlaying for $url');
    } catch (e) {
      emit(AudioPlayerError('فشل في تشغيل الصوت'));
      print('[ERROR] Failed to play audio: $e');
    }
  }

  Future<void> stop() async {
    print('[ACTION] Stop audio');
    await _player.stop();
    emit(AudioPlayerPaused());
    print('[STATE] AudioPlayerPaused (after stop)');
  }

  Future<void> pause() async {
    print('[ACTION] Pause audio');
    await _player.pause();
    emit(AudioPlayerPaused());
    print('[STATE] AudioPlayerPaused');
  }

  Future<void> play() async {
    print('[ACTION] Play audio');
    await _player.play();
    if (currentUrl != null) {
      emit(AudioPlayerPlaying(currentUrl!));
      print('[STATE] AudioPlayerPlaying for $currentUrl');
    }
  }

  void _handlePlayerState(PlayerState state) {
    print('[PLAYER STATE] ${state.processingState}');
    if (state.processingState == ProcessingState.completed) {
      emit(AudioPlayerCompleted());
      print('[STATE] AudioPlayerCompleted');
    }
  }

  void _handlePositionStream(Duration position) {
    final duration = _player.duration;
    if (duration != null) {
      final progress = position.inMilliseconds / duration.inMilliseconds;
      emit(AudioPlayerProgress(progress.clamp(0.0, 1.0)));
      print('[PROGRESS] ${(progress * 100).clamp(0.0, 100.0).toStringAsFixed(2)}%');
    }
  }

  @override
  Future<void> close() {
    print('[DISPOSE] AudioPlayerCubit disposed');
    _player.dispose();
    return super.close();
  }
}
