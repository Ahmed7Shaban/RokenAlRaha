import 'package:hive/hive.dart';

part 'ayah_like_model.g.dart';

@HiveType(typeId: 4)
class AyahLikeModel extends HiveObject {
  @HiveField(0)
  final String surahName;

  @HiveField(1)
  final String ayahText;

  @HiveField(2)
  final int ayahNumber;

  @HiveField(3)
  final String audioUrl;

  AyahLikeModel({
    required this.surahName,
    required this.ayahText,
    required this.ayahNumber,
    required this.audioUrl,
  });
}
