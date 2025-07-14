// lib/features/daily_aya/logic/aya_manager.dart

import '../presentation/data/aya_list.dart';
import 'aya_storage.dart';

class AyaManager {
  final AyaStorage storage = AyaStorage();

  Future<String> getTodayAya() async {
    await storage.saveStartDateIfNotExists();

    final startDate = await storage.getStartDate();
    final daysPassed = DateTime.now().difference(startDate).inDays;
    final index = daysPassed % ayaList.length;

    return ayaList[index];
  }
}
