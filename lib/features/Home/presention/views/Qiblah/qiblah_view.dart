import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

import '../../../../../routes/routes.dart';
import 'widget/qiblah_compass.dart';

class QiblahView extends StatefulWidget {
  const QiblahView({Key? key}) : super(key: key);
  static const String routeName = Routes.QiblahView;
  @override
  State<QiblahView> createState() => _QiblahViewState();
}

class _QiblahViewState extends State<QiblahView> {
  bool _locationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final status = await Permission.location.request();
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    setState(() {
      _locationPermissionGranted =
          status == PermissionStatus.granted && serviceEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _locationPermissionGranted
            ? const QiblahCompass()
            : _buildLocationErrorWidget(),
      ),
    );
  }

  Widget _buildLocationErrorWidget() {
    return Center(
      child: AlertDialog(
        backgroundColor: AppColors.pureWhite,
        title: Lottie.asset(
          'assets/lottie/Location.json',
          width: 80,
          height: 80,
          repeat: true,
        ),
        content: Text(
          "يرجى تفعيل الموقع للحصول على اتجاه القبلة بدقة.",
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 20,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: _checkPermissions,
            child: Text(
              "تفعيل الموقع",
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.pureWhite,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "إغلاق",
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
        ],
      )
    );

  }
}
