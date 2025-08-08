

import '../../../../../../routes/routes.dart';
import '../../../../../../source/app_images.dart';
import '../../../../models/service_item.dart';

final List<ServiceItem> zekrItemList = [

  ServiceItem(
    iconPath: Assets.imagesSunrise,
    label: ' الصباح',
    route: Routes.MorningAzkar,
  ),


  ServiceItem(
    iconPath: Assets.imagesNight,
    label: ' المساء',
    route: Routes.EveningAzkar,
  ),

  ServiceItem(
    iconPath: Assets.imagesGetUp,
    label: ' الاستيقاظ',
    route: Routes.WakeUpAzkar,
  ),
  ServiceItem(
    iconPath: Assets.imagesSleep,
    label: ' النوم',
    route: Routes.SleepAzkar,
  ),



  ServiceItem(
    iconPath: Assets.mosque1,
    label: 'دخول المسجد',
    route: Routes.MosqueInAzkar,
  ),

  ServiceItem(
    iconPath: Assets.mosqueExit,
    label: 'الخروج من المسجد',
    route: Routes.MosqueOutAzkar,
  ),

  ServiceItem(
    iconPath: Assets.open, // أيقونة دخول المنزل
    label: 'دخول المنزل',
    route: Routes.HomeInAzkar,
  ),

  ServiceItem(
    iconPath: Assets.draw, // أيقونة الخروج من المنزل
    label: 'الخروج من المنزل',
    route: Routes.HomeOutAzkar,
  ),

  ServiceItem(
    iconPath: Assets.travel, // أيقونة السفر
    label: 'السفر',
    route: Routes.TravelAzkar,
  ),

  ServiceItem(
    iconPath: Assets.wcEnter, // أيقونة دخول الخلاء
    label: 'دخول الخلاء',
    route: Routes.ToiletInAzkar,
  ),

  ServiceItem(
    iconPath: Assets.wcExit, // أيقونة الخروج من الخلاء
    label: 'الخروج من الخلاء',
    route: Routes.ToiletOutAzkar,
  ),

  ServiceItem(
    iconPath: Assets.transport, // أيقونة الركوب
    label: 'دعاء الركوب',
    route: Routes.TransportAzkar,
  ),

  ServiceItem(
    iconPath: Assets.stkara, // أيقونة الاستخارة
    label: 'دعاء الاستخارة',
    route: Routes.IstikharaAzkar,
  ),

  ServiceItem(
    iconPath: Assets.rain, // أيقونة المطر
    label: 'دعاء المطر',
    route: Routes.RainAzkar,
  ),


  ServiceItem(
    iconPath: Assets.note,
    label: 'أذكارى',
    route: Routes.Azkary,
  ),



  //
  // ServiceItem(
  //   iconPath:'',
  //   label: ' دخول المسجد',
  //   route: "",
  // ),
  //
  // ServiceItem(
  //   iconPath:'',
  //   label: ' الخروج من المسجد',
  //   route: "",
  // ),
  //
  // ServiceItem(
  //   iconPath:'',
  //   label: ' الخروج من المسجد',
  //   route: "",
  // ),

];
