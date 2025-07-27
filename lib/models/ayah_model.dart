class AyahModel {
  final int number;
  final int numberInSurah; // ✅ أضفنا ده
  final String text;
  final String audio;

  AyahModel({
    required this.number,
    required this.numberInSurah, // ✅
    required this.text,
    required this.audio,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'],
      numberInSurah: json['numberInSurah'], // ✅
      text: json['text'],
      audio: json['audio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'numberInSurah': numberInSurah, // ✅
      'text': text,
      'audio': audio,
    };
  }
}
