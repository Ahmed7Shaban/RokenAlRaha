import 'package:flutter/material.dart';
import '../../../../date/service_items_list.dart';
import '../card/card_services.dart';

class HomeServicesGrid extends StatelessWidget {
  const HomeServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 15,
      mainAxisSpacing: 20,
      children: List.generate(serviceItemsList.length, (index) {
        final item = serviceItemsList[index];
        return CardServices(
          item: item,
          index: index,
          onTap: () {
            Navigator.pushNamed(context, item.route);
          },
        );
      }),
    );
  }
}
