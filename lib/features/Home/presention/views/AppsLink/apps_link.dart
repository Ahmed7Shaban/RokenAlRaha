// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../../../core/widgets/lottie_loader.dart';
// import '../../../../../routes/routes.dart';
//
//
//
//
// class AppsLink extends StatelessWidget {
//   static const String routeName = Routes.apps;
//
//   const AppsLink({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     _launchPlayStore();
//
//     return const Scaffold(
//       body:LottieLoader()
//     );
//   }
//
//   void _launchPlayStore() async {
//     const developerUrl = 'https://play.google.com/store/apps/dev?id=5205274722276092662';
//     final uri = Uri.parse(developerUrl);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:roken_raha/core/widgets/lottie_loader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants.dart';
import '../../../../../routes/routes.dart';

class AppsLink extends StatefulWidget {
   static const String routeName = Routes.apps;
  const AppsLink({super.key});

  @override
  State<AppsLink> createState() => _AppsLinkState();
}

class _AppsLinkState extends State<AppsLink> {
  @override
  void initState() {
    super.initState();
    _openDeveloperPage();
  }

  Future<void> _openDeveloperPage() async {
    const String url = AppsLinks.appStoreUrl;
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّر فتح المتجر')),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LottieLoader();
  }
}

