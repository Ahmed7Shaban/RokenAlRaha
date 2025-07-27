import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/asmaa_repository.dart';
import 'asmaa_state.dart';

class AsmaaCubit extends Cubit<AsmaaState> {
  final AsmaaRepository repository;

  AsmaaCubit(this.repository) : super(AsmaaInitial());

  Future<void> loadAsmaa() async {
    emit(AsmaaLoading());
    try {
      final list = await repository.fetchAsmaaAllah();
      emit(AsmaaLoaded(list));
    } catch (e) {
      emit(AsmaaError('حدث خطأ أثناء تحميل الأسماء'));
    }
  }
}
