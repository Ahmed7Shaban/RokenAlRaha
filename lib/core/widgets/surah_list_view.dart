// import 'package:flutter/material.dart';

// import '../../models/surah_model.dart';
// import '../../services/quran_service.dart';

// // شاشة بتعرض قائمة السور، كل واحدة تفتح صفحة تفاصيل
// class SurahListView extends StatelessWidget {
//   const SurahListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       // FutureBuilder بينتظر لما السور تتجاب
//       body: FutureBuilder<List<SurahModel>>(
//         future: QuranService().fetchAllSurahs(),
//         builder: (context, snapshot) {
//           // أثناء التحميل
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // لو حصل خطأ
//           if (snapshot.hasError) {
//             return Center(child: Text('خطأ: ${snapshot.error}'));
//           }

//           // السور وصلت بنجاح
//           final surahs = snapshot.data!;

//           return ListView.builder(
//             itemCount: surahs.length,
//             itemBuilder: (context, index) {
//               final surah = surahs[index];

//               return ListTile(
//                 title: Text(surah.name), // اسم السورة
//                 subtitle: Text(
//                   '${surah.revelationType == "Meccan" ? "مكية" : "مدنية"} - ${surah.numberOfAyahs} آية',
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios),
//                 onTap: () {
//                   // لما المستخدم يدوس على السورة، يروح لصفحة التفاصيل
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => SurahDetailView(surah: surah),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
