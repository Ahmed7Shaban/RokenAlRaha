abstract class AudioPlayerState {}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerLoading extends AudioPlayerState {}

class AudioPlayerPlaying extends AudioPlayerState {
  final String url;
  AudioPlayerPlaying(this.url);
}

class AudioPlayerPaused extends AudioPlayerState {}

class AudioPlayerCompleted extends AudioPlayerState {}

class AudioPlayerProgress extends AudioPlayerState {
  final double progress;
  AudioPlayerProgress(this.progress);
}

class AudioPlayerError extends AudioPlayerState {
  final String message;
  AudioPlayerError(this.message);
}
