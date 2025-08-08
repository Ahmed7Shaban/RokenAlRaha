

import '../../../../../../../../routes/routes.dart';
import '../../../../../../../../source/app_images.dart';
import '../../../../../../models/service_item.dart';


final List<ServiceItem> AzkarList = [


  ServiceItem(
    iconPath: Assets.imagesSunrise,
    label: ' الصباح',
    route: Routes.MorningNot,
  ),


  ServiceItem(
    iconPath: Assets.imagesNight,
    label: ' المساء',
    route: Routes.EveningNot,
  ),
  //
  // ServiceItem(
  //   iconPath: Assets.imagesGetUp,
  //   label: ' الاستيقاظ',
  //   route: Routes.WakeUpAzkar,
  // ),
  // ServiceItem(
  //   iconPath: Assets.imagesSleep,
  //   label: ' النوم',
  //   route: Routes.SleepAzkar,
  // ),
  ServiceItem(
    iconPath: Assets.muhammad,
    label: " صلاة على النبي",
    route: Routes.DhikrMohammed,
  ),





];
