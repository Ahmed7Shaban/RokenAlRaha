part of 'daily_aya_cubit.dart';

abstract class DailyAyaState {}

class DailyAyaLoading extends DailyAyaState {}

class DailyAyaLoaded extends DailyAyaState {
  final String aya;
  DailyAyaLoaded(this.aya);
}
