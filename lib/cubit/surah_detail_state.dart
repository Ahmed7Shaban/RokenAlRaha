abstract class SurahDetailState {}

class SurahDetailInitial extends SurahDetailState {}

class SurahDetailLoading extends SurahDetailState {}

class SurahDetailLoaded extends SurahDetailState {
  final List<Map<String, dynamic>> ayahs;

  SurahDetailLoaded(this.ayahs);
}

class SurahDetailError extends SurahDetailState {
  final String message;

  SurahDetailError(this.message);
}
