import 'surah_model.dart';

class QuranResponse {
  final List<SurahModel> surahs;

  QuranResponse({required this.surahs});

  factory QuranResponse.fromJson(Map<String, dynamic> json) {
    return QuranResponse(
      surahs: (json['data']['surahs'] as List)
          .map((e) => SurahModel.fromJson(e))
          .toList(),
    );
  }
}
