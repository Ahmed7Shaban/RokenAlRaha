import 'package:flutter/material.dart';

import '../../../../../../routes/routes.dart';
import '../special_azkar_view.dart';

class HawqalahView extends StatelessWidget {
  const HawqalahView({super.key});
  static const String routeName = Routes.Hawqalah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpecialAzkarView(title: 'لاحول ولاقوة إلا بالله', ZkrName: 'لاحول ولاقوة إلا بالله العلي العظيم',),
    );
  }
}
