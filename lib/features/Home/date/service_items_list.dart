import '../../../routes/routes.dart';
import '../../../source/app_images.dart';
import '../models/service_item.dart';

final List<ServiceItem> serviceItemsList = [
  ServiceItem(
    iconPath: Assets.imagesQuran,
    label: 'اقرأ القرآن',
    route: Routes.quranReading,
  ),
  ServiceItem(
    iconPath: Assets.playAyah,
    label: 'استمع للآيات',
    route: Routes.ayahAudio,
  ),
  ServiceItem(
    iconPath: Assets.imagesHeadphones,
    label: 'استمع للقرآن',
    route: Routes.surahAudio,
  ),
  ServiceItem(
    iconPath: Assets.liked,
    label: 'الايات المفضلة',
    route: Routes.AyahLiked,
  ),

  ServiceItem(
    iconPath: Assets.imagesTasbih,
    label: ' تسبيح ',
    route: Routes.tasbeehView,
  ),
  ServiceItem(
    iconPath: Assets.imagesPrayer,
    label: 'أستغفار',
    route: Routes.istighfarView,
  ),
  ServiceItem(
    iconPath: Assets.tasbihList,
    label: "سجل المسبحة",
    route: Routes.SaveMasbaha,
  ),

  ServiceItem(
    iconPath: Assets.allah,
    label: "أسماء اللّٰه الحسنى",
    route: Routes.AsmaaAllah,
  ),

  ServiceItem(
    iconPath: Assets.hamed,
    label: "الحمد",
    route: Routes.hamed,
  ),

  ServiceItem(
    iconPath: Assets.dua,
    label: "ادعية الانبياء",
    route: Routes.Duaas,
  ),

  ServiceItem(
    iconPath: Assets.duaQ,
    label: "ادعية قرانية",
    route: Routes.DuaasQ,
  ),

  ServiceItem(
    iconPath: Assets.muhammad,
    label: " صلاة على النبي",
    route: Routes.SalatAlnabi,
  ),

  ServiceItem(
    iconPath: Assets.premium,
    label: "كنز الجنة",
    route: Routes.Hawqalah,
  ),

  ServiceItem(
    iconPath: Assets.whale,
    label: "دعاء الكرب",
    route: Routes.DuaYunus,
  ),

  ServiceItem(
    iconPath: Assets.Ruqyah,
    label: "الرُقية الشرعية ",
    route: Routes.Ruqyah,
  ),
  ServiceItem(
    iconPath: Assets.azkar,
    label: "الأذكار ",
    route: Routes.AllAzkar,
  ),
];
