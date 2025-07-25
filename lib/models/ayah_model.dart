class AyahModel {
  final int numberInSurah;
  final String text;
  final String audio;

  AyahModel({
    required this.numberInSurah,
    required this.text,
    required this.audio,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      numberInSurah: json['numberInSurah'],
      text: json['text'],
      audio: json['audio'],
    );
  }
}
