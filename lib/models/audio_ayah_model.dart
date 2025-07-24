class AudioAyahModel {
  final int numberInSurah;
  final String text;
  final String audio;
  final int surahNumber;

  AudioAyahModel({
    required this.numberInSurah,
    required this.text,
    required this.audio,
    required this.surahNumber,
  });

  factory AudioAyahModel.fromJson(Map<String, dynamic> json) {
    return AudioAyahModel(
      numberInSurah: json['numberInSurah'],
      text: json['text'],
      audio: json['audio'],
      surahNumber: json['surah']['number'],
    );
  }
}
