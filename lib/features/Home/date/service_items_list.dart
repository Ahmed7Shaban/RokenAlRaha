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
    iconPath: Assets.imagesBookmark,
    label: 'أكمِل قراءتك',
    route: '/quran',
  ),
  ServiceItem(
    iconPath: Assets.imagesHeadphones,
    label: 'استمع للقرآن',
    route: '/quran',
  ),
];
