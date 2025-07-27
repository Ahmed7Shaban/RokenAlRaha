import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../../../../../../routes/routes.dart';
import 'cubit/zikr_cubit.dart';
import 'widget/add_zikr_bottom_sheet.dart';
import 'widget/body_azkary.dart';
import 'widget/floating_button.dart';
import 'widget/zikry_item.dart';


class AzkaryView extends StatelessWidget {
  const AzkaryView({super.key});
  static const String routeName = Routes.Azkary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BodyAzkary(),

      floatingActionButton:FloatingButton(),
    );
  }
}

