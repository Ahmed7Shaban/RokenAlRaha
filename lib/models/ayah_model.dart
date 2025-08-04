import 'package:hive/hive.dart';

part 'ayah_model.g.dart';

@HiveType(typeId: 3)
class AyahModel {
  @HiveField(0)
  final int number;

  @HiveField(1)
  final int numberInSurah;

  @HiveField(2)
  final String text;

  @HiveField(3)
  final String audio;

  AyahModel({
    required this.number,
    required this.numberInSurah,
    required this.text,
    required this.audio,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'],
      numberInSurah: json['numberInSurah'],
      text: json['text'],
      audio: json['audio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'numberInSurah': numberInSurah,
      'text': text,
      'audio': audio,
    };
  }
}
