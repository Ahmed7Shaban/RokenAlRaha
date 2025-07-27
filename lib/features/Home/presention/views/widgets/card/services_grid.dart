import 'package:flutter/material.dart';
import '../../../../date/service_items_list.dart';
import '../../../../models/service_item.dart';
import '../card/card_services.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key, required this.list});
  final List<ServiceItem> list;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 15,
      mainAxisSpacing: 20,
      children: List.generate(list.length, (index) {
        final item = list[index];
        return CardServices(
          item: item,
          index: index,
          onTap: () {
            Navigator.pushNamed(context, item.route);
            print("object: ${item.route}"); // Debugging line to check the route
          },
        );
      }),
    );
  }
}
