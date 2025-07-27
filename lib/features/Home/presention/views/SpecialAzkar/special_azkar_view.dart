import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:roken_raha/core/widgets/appbar_widget.dart';

import '../../../../../core/widgets/count_action.dart';
import '../../../../../core/widgets/count_text.dart';
import 'widget/zkar_card.dart';

class SpecialAzkarView extends StatefulWidget {
  const SpecialAzkarView({super.key, required this.title, required this.ZkrName});

  final String title;
  final String ZkrName;

  @override
  State<SpecialAzkarView> createState() => _SpecialAzkarViewState();
}

class _SpecialAzkarViewState extends State<SpecialAzkarView> {
  int _count = 0;
  CountAction? _action;

  void _increaseCount() {
    setState(() {
      _count++;
      _action = CountAction.increase;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          AppbarWidget(title: widget.title),
          const SizedBox(height: 10),
      
          CountText(
            count: _count.toString(),
            action: _action,
          ),
      
          const SizedBox(height: 10),
      
          Lottie.asset("assets/lottie/dua.json", width: 200, height: 200),
      
          const SizedBox(height: 10),
      
          ZkarCard(
            name: widget.ZkrName,
            onTap: _increaseCount,
          ),
        ],
      ),
    );
  }
}
