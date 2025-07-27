import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../model/zikr_model.dart';

part 'zikr_state.dart';

class ZikrCubit extends Cubit<ZikrState> {
  ZikrCubit() : super(ZikrInitial());

  late Box<ZikrModel> _zikrBox;

  Future<void> init() async {
    emit(ZikrLoading());
    try {
      _zikrBox = Hive.box<ZikrModel>('azkarBox');
      emit(ZikrLoaded(_zikrBox.values.toList()));
    } catch (e) {
      emit(ZikrError('فشل تحميل البيانات: $e'));
    }
  }

  Future<void> addZikr(ZikrModel zikr) async {
    try {
      if (!_zikrBox.isOpen) {
        _zikrBox = Hive.box<ZikrModel>('azkarBox');
      }

      await _zikrBox.add(zikr);
      emit(ZikrLoaded(_zikrBox.values.toList()));
    } catch (e) {
      emit(ZikrError('فشل إضافة الذكر: $e'));
    }
  }

  Future<void> deleteZikr(int key) async {
    try {
      emit(ZikrLoading());
      await _zikrBox.delete(key); // استخدم _zikrBox
      emit(ZikrLoaded(_zikrBox.values.toList())); // عشان تحدث الليست
    } catch (e) {
      emit(ZikrError("فشل حذف الذكر: $e"));
    }
  }

  Future<void> updateZikr(int index, ZikrModel updatedZikr) async {
    try {
      await _zikrBox.putAt(index, updatedZikr);
      emit(ZikrLoaded(_zikrBox.values.toList()));
    } catch (e) {
      emit(ZikrError('فشل تعديل الذكر: $e'));
    }
  }

  Future<void> clearAllZikr() async {
    try {
      await _zikrBox.clear();
      emit(ZikrLoaded([]));
    } catch (e) {
      emit(ZikrError('فشل مسح الأذكار: $e'));
    }
  }

  Future<void> refreshZikr() async {
    try {
      emit(ZikrLoaded(_zikrBox.values.toList()));
    } catch (e) {
      emit(ZikrError('حدث خطأ أثناء التحديث: $e'));
    }
  }
}
