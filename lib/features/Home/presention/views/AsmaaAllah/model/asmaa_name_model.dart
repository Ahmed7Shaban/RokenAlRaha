class AsmaaAllahModel {
  final int id;
  final String name;
  final String text;

  AsmaaAllahModel({
    required this.id,
    required this.name,
    required this.text,
  });

  factory AsmaaAllahModel.fromJson(Map<String, dynamic> json) {
    return AsmaaAllahModel(
      id: json['id'],
      name: json['name'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'text': text,
    };
  }
}
