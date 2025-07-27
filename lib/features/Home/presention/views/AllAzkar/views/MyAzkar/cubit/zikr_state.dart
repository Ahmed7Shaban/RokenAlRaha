part of 'zikr_cubit.dart';

abstract class ZikrState {}

class ZikrInitial extends ZikrState {}

class ZikrLoading extends ZikrState {}

class ZikrLoaded extends ZikrState {
  final List<ZikrModel> zikrList;

  ZikrLoaded(this.zikrList);
}

class ZikrError extends ZikrState {
  final String message;

  ZikrError(this.message);
}
