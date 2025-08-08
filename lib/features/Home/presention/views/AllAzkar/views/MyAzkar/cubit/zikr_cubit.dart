import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../../../../../storage/zikr_storage_service.dart';
import '../model/zikr_model.dart';

part 'zikr_state.dart';

class ZikrCubit extends Cubit<ZikrState> {
  ZikrCubit() : super(ZikrInitial());

  late Box<ZikrModel> _zikrBox;

  Future<void> init() async {
    emit(ZikrLoading());
    print('[ZikrCubit] Initializing...');
    try {
      _zikrBox = Hive.box<ZikrModel>('azkarBox');
      print('[ZikrCubit] Loaded ${_zikrBox.length} items.');
      emit(ZikrLoaded(_zikrBox.values.toList()));
    } catch (e) {
      print('[ZikrCubit] Error during init: $e');
      emit(ZikrError('فشل تحميل البيانات: $e'));
    }
  }

  Future<void> addZikr(ZikrModel zikr) async {
    try {
      emit(ZikrLoading());
      await ZikrService.addZikr(zikr);
      final allZikr = await ZikrService.getAllZikr();
      emit(ZikrLoaded(allZikr));
    } catch (e) {
      emit(ZikrError('حدث خطأ أثناء إضافة الذكر'));
    }
  }

  Future<void> deleteZikr(int key) async {
    print('[ZikrCubit] Deleting zikr with key: $key');
    try {
      emit(ZikrLoading());
      await _zikrBox.delete(key);
      print('[ZikrCubit] Zikr deleted. Remaining: ${_zikrBox.length}');
      emit(ZikrLoaded(_zikrBox.values.toList()));
    } catch (e) {
      print('[ZikrCubit] Error while deleting zikr: $e');
      emit(ZikrError("فشل حذف الذكر: $e"));
    }
  }

  Future<void> updateZikr(int index, ZikrModel updatedZikr) async {
    print('[ZikrCubit] Updating zikr at index $index with title: ${updatedZikr.title}');
    try {
      await _zikrBox.putAt(index, updatedZikr);
      print('[ZikrCubit] Zikr updated.');
      emit(ZikrLoaded(_zikrBox.values.toList()));
    } catch (e) {
      print('[ZikrCubit] Error while updating zikr: $e');
      emit(ZikrError('فشل تعديل الذكر: $e'));
    }
  }

  Future<void> clearAllZikr() async {
    print('[ZikrCubit] Clearing all azkar...');
    try {
      await _zikrBox.clear();
      print('[ZikrCubit] All azkar cleared.');
      emit(ZikrLoaded([]));
    } catch (e) {
      print('[ZikrCubit] Error while clearing azkar: $e');
      emit(ZikrError('فشل مسح الأذكار: $e'));
    }
  }

  Future<void> refreshZikr() async {
    print('[ZikrCubit] Refreshing azkar list...');
    try {
      emit(ZikrLoaded(_zikrBox.values.toList()));
      print('[ZikrCubit] Azkar list refreshed.');
    } catch (e) {
      print('[ZikrCubit] Error while refreshing: $e');
      emit(ZikrError('حدث خطأ أثناء التحديث: $e'));
    }
  }

  void loadZikr() async {
    emit(ZikrLoading());
    try {
      final list = await ZikrService.getAllZikr();
      emit(ZikrLoaded(list));
    } catch (e) {
      emit(ZikrError('حدث خطأ أثناء التحميل'));
    }
  }

}
