import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../storage/ayah_like_storage.dart';
import '../model/ayah_like_model.dart';

part 'ayah_like_state.dart';

class AyahLikeCubit extends Cubit<AyahLikeState> {
  AyahLikeCubit() : super(AyahLikeInitial());

  void loadLikedAyahs() async {
    final likedAyahs = await AyahLikeStorage.getLikedAyahs();
    emit(AyahLikeLoaded(likedAyahs));
  }

  Future<void> likeAyah(AyahLikeModel ayah) async {
    await AyahLikeStorage.likeAyah(ayah);
    loadLikedAyahs();
  }



  Future<void> removeAyah(int index) async {
    await AyahLikeStorage.removeAyah(index);
    loadLikedAyahs();
  }
  Future<void> toggleLike(AyahLikeModel ayah) async {
    final index = await AyahLikeStorage.getAyahIndex(ayah.surahName, ayah.ayahNumber);

    if (index != null) {
      await AyahLikeStorage.removeAyah(index);
    } else {
      await AyahLikeStorage.likeAyah(ayah);
    }

    loadLikedAyahs();
  }

}
