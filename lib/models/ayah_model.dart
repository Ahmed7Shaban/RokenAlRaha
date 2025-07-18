class AyahModel {
  final int number;
  final String text;
  final int numberInSurah;

  AyahModel({
    required this.number,
    required this.text,
    required this.numberInSurah,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'],
      text: json['text'],
      numberInSurah: json['numberInSurah'],
    );
  }
}
