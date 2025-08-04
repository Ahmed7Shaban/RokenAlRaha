part of 'ayah_like_cubit.dart';

abstract class AyahLikeState {}

class AyahLikeInitial extends AyahLikeState {}

class AyahLikeLoaded extends AyahLikeState {
  final List<AyahLikeModel> likedAyahs;

  AyahLikeLoaded(this.likedAyahs);
}
