import 'package:flutter/material.dart';
import 'package:roken_raha/features/Home/presention/views/widgets/card/card_services.dart';

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
      children: const [
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
        CardServices(
          iconPath: 'assets/Images/petik.svg',
          label: 'القرآن الكريم',
        ),
      ],
    );
  }
}
