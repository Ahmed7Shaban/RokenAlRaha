import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/theme/app_colors.dart';

class TimeNowText extends StatefulWidget {
  const TimeNowText({super.key});

  @override
  State<TimeNowText> createState() => _TimeNowTextState();
}

class _TimeNowTextState extends State<TimeNowText> {
  late Timer _timer;
  late String _timeString;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeString = _formatDateTime(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss a').format(dateTime);  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: AppColors.goldenYellow),
    );
  }
}
