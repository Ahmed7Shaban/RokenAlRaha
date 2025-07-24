part of 'audio_player_cubit.dart';

abstract class AudioPlayerState {}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerLoading extends AudioPlayerState {}

class AudioPlayerPlaying extends AudioPlayerState {
  final String url;
  AudioPlayerPlaying(this.url);
}

class AudioPlayerStopped extends AudioPlayerState {}

class AudioPlayerError extends AudioPlayerState {
  final String message;
  AudioPlayerError(this.message);
}
