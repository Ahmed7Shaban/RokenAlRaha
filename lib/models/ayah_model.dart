class AyahModel {
  final int number;
  final String text;
  final String? audio;

  AyahModel({required this.number, required this.text, this.audio});

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'] ?? 0,
      text: json['text'] ?? '',
      audio: json['audio'], // ممكن تبقى null
    );
  }
}
