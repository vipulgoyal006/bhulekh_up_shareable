import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SponsoredSection extends StatelessWidget {
  final AdmobBannerSize size;

  SponsoredSection({Key? key, required this.size}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AdmobBanner(
      nonPersonalizedAds: true,
      adUnitId: "ca-app-pub-2451593635555466/2312067092",
      adSize: size,
    );
  }
}
