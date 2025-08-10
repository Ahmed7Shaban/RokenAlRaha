import 'package:flutter/material.dart';
import '../../../../../../core/ads/ad_service.dart';
import '../../../../date/service_items_list.dart';
import '../../../../models/service_item.dart';
import '../card/card_services.dart';

class ServicesGrid extends StatefulWidget {
  const ServicesGrid({super.key, required this.list});
  final List<ServiceItem> list;

  @override
  State<ServicesGrid> createState() => _ServicesGridState();
}

class _ServicesGridState extends State<ServicesGrid> {
  int _tapCount = 0;

  void _handleTap(ServiceItem item) {
    _tapCount++;

    if (_tapCount >= 3) {
      AdService.showInterstitialAd();
      _tapCount = 0;
    }

    Navigator.pushNamed(context, item.route);
    print("object: ${item.route}");
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 15,
      mainAxisSpacing: 20,
      children: List.generate(widget.list.length, (index) {
        final item = widget.list[index];
        return CardServices(
          item: item,
          index: index,
          onTap: () => _handleTap(item),
        );
      }),
    );
  }
}
