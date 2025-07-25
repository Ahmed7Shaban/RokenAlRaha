
 class AudioSequenceState  {}

class AudioSequenceInitial extends AudioSequenceState {}

class AudioSequenceLoading extends AudioSequenceState {}

class AudioSequencePlaying extends AudioSequenceState {
  final int index;

  AudioSequencePlaying({required this.index});
}

class AudioSequencePaused extends AudioSequenceState {
  final int index;

  AudioSequencePaused({required this.index});
}

class AudioSequenceCompleted extends AudioSequenceState {}

class AudioSequenceError extends AudioSequenceState {}
class AudioSequenceNoConnection extends AudioSequenceState {}
