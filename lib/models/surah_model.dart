
import 'package:hive/hive.dart';

part 'surah_model.g.dart';

@HiveType(typeId: 2)
class SurahModel extends HiveObject {
  @HiveField(0)
  final int number;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int numberOfAyahs;

  @HiveField(3)
  final String revelationType;

  SurahModel({
    required this.number,
    required this.name,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    if (json['number'] == null || json['name'] == null || json['numberOfAyahs'] == null || json['revelationType'] == null) {
      print("❗تحذير: بيانات ناقصة في JSON: $json");
    }

    return SurahModel(
      number: json['number'] ?? 0,
      name: json['name'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
      revelationType: json['revelationType'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'numberOfAyahs': numberOfAyahs,
      'revelationType': revelationType,
    };
  }
}




// import 'ayah_like_model.dart';
//
// class SurahModel {
//   final int number;
//   final String name;
//   final String englishName;
//   final String englishNameTranslation;
//   final String revelationType;
//   final List<AyahModel> ayahs;
//
//   SurahModel({
//     required this.number,
//     required this.name,
//     required this.englishName,
//     required this.englishNameTranslation,
//     required this.revelationType,
//     required this.ayahs,
//   });
//
//   factory SurahModel.fromJson(Map<String, dynamic> json) {
//     return SurahModel(
//       number: json['number'],
//       name: json['name'],
//       englishName: json['englishName'],
//       englishNameTranslation: json['englishNameTranslation'],
//       revelationType: json['revelationType'],
//       ayahs: (json['ayahs'] as List<dynamic>)
//           .map((e) => AyahModel.fromJson(Map<String, dynamic>.from(e)))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'number': number,
//       'name': name,
//       'englishName': englishName,
//       'englishNameTranslation': englishNameTranslation,
//       'revelationType': revelationType,
//       'ayahs': ayahs.map((e) => e.toJson()).toList(),
//     };
//   }
// }
