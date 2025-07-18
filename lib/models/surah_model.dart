import 'ayah_model.dart';

class SurahModel {
  final int number; // رقم السورة
  final String name; // اسم السورة
  final String revelationType; // مكية أو مدنية
  final int numberOfAyahs; // عدد الآيات
  final List<AyahModel> ayahs; // الآيات

  SurahModel({
    required this.number,
    required this.name,
    required this.revelationType,
    required this.numberOfAyahs,
    required this.ayahs,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'] ?? 0,
      name: json['name'] ?? 'بدون اسم',
      revelationType: json['revelationType'] ?? 'غير معروف',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
      ayahs:
          (json['ayahs'] as List?)?.map((ayahJson) {
            return AyahModel.fromJson(ayahJson);
          }).toList() ??
          [],
    );
  }
}
