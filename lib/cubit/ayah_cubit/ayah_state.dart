import '../../models/ayah_model.dart';

abstract class AyahState {}

class AyahInitial extends AyahState {}

class AyahLoading extends AyahState {}

class AyahLoaded extends AyahState {
  final List<AyahModel> ayahList;

  AyahLoaded(this.ayahList);
}

class AyahError extends AyahState {
  final String message;

  AyahError(this.message);
}
