

import '../../../../../../routes/routes.dart';
import '../../../../../../source/app_images.dart';
import '../../../../models/service_item.dart';

final List<ServiceItem> SettingList = [

  ServiceItem(
    iconPath: Assets.prayerA,
    label: ' الأذان',
    route: Routes.prayerNot,
  ),
  ServiceItem(
    iconPath: Assets.tasbihList,
    label: ' إشعارات الاذكار',
    route: Routes.AzkarNot,
  ),


];
