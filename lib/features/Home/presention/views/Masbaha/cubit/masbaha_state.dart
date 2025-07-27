part of 'masbaha_cubit.dart';

abstract class MasbahaState {}

class MisbahaInitial extends MasbahaState {}

class MisbahaUpdated extends MasbahaState {
  final int count;
  final int seconds;
  final bool isMilestone;

  MisbahaUpdated({
    required this.count,
    required this.seconds,
    required this.isMilestone,
  });
}
