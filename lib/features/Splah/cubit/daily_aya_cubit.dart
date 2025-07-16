import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/aya_list.dart';
import '../logic/aya_storage.dart';

part 'daily_aya_state.dart';

class DailyAyaCubit extends Cubit<DailyAyaState> {
  final AyaStorage _storage;

  DailyAyaCubit(this._storage) : super(DailyAyaLoading()) {
    loadTodayAya();
  }

  Future<void> loadTodayAya() async {
    await _storage.saveStartDateIfNotExists();
    final startDate = await _storage.getStartDate();
    final daysPassed = DateTime.now().difference(startDate).inDays;
    final index = daysPassed % ayaList.length;
    emit(DailyAyaLoaded(ayaList[index]));
  }
}
