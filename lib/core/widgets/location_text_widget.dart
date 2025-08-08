import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

class LocationTextWidget extends StatefulWidget {
  @override
  _LocationTextWidgetState createState() => _LocationTextWidgetState();
}

class _LocationTextWidgetState extends State<LocationTextWidget> {
  String _locationMessage = 'جاري تحديد الموقع...';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationMessage = '⚠️ خدمة الموقع غير مفعلة';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationMessage = '⚠️ تم رفض إذن الموقع';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationMessage = '🚫 إذن الموقع مرفوض دائمًا، فعّله من الإعدادات';
        });
        return;
      }

      // الحصول على الموقع الحالي
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // استخدام timeout لتفادي الانتظار الطويل في geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('⏰ انتهت مهلة جلب الموقع');
        },
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _locationMessage = '${place.locality}, ${place.country}';
        });
      } else {
        setState(() {
          _locationMessage = '❌ لم يتم العثور على موقع مناسب';
        });
      }
    } catch (e) {
      setState(() {
        _locationMessage = '❌ تعذر تحديد الموقع: ${e is TimeoutException ? "انتهت المهلة" : "خطأ غير متوقع"}';
      });
      print('⚠️ خطأ أثناء جلب الموقع: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _locationMessage,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: AppColors.goldenYellow),
      textAlign: TextAlign.center,
    );
  }
}
