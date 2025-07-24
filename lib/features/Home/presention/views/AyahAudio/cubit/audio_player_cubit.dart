import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  static final AudioPlayer _player = AudioPlayer();
  String? _currentUrl;

  AudioPlayerCubit() : super(AudioPlayerInitial()) {
    // الاستماع لانتهاء الصوت
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        emit(AudioPlayerStopped());
      }
    });
  }

  Future<void> play(String url) async {
    try {
      if (_currentUrl == url && _player.playing) {
        await _player.stop();
        emit(AudioPlayerStopped());
        return;
      }

      emit(AudioPlayerLoading());

      if (_player.playing) {
        await _player.stop();
      }

      _currentUrl = url;
      await _player.setUrl(url);

      await _player.play();

      // ✨ ننتظر لحد ما يبقى فعلاً شغال (حالة playing)
      _player.playerStateStream.listen((state) {
        if (state.playing && state.processingState == ProcessingState.ready) {
          emit(AudioPlayerPlaying(url));
        }
      }).onError((e) {
        emit(AudioPlayerError("خطأ أثناء التشغيل"));
      });

    } catch (e) {
      emit(AudioPlayerError("حدث خطأ أثناء تشغيل الصوت"));
    }
  }

  Future<void> stop() async {
    await _player.stop();
    emit(AudioPlayerStopped());
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}
