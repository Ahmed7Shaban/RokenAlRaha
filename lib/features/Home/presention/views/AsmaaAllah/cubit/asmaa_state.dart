
import '../model/asmaa_name_model.dart';

abstract class AsmaaState {}

class AsmaaInitial extends AsmaaState {}

class AsmaaLoading extends AsmaaState {}

class AsmaaLoaded extends AsmaaState {
  final List<AsmaaAllahModel> asmaa;
  AsmaaLoaded(this.asmaa);
}

class AsmaaError extends AsmaaState {
  final String message;
  AsmaaError(this.message);
}
