import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../ad_service.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = AdService.createBannerAd(
      onLoaded: () => setState(() => _isLoaded = true),
      onFailed: () => setState(() => _isLoaded = false),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding:EdgeInsets.symmetric(horizontal: 15,vertical: 15) ,
        alignment: Alignment.center,
        child: AdWidget(ad: _bannerAd!),
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
