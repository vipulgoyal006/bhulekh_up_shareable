import 'package:bhulekh_up/app_configs/app_asset.dart';
import 'package:bhulekh_up/pages/district/controller/district_controller.dart';
import 'package:bhulekh_up/pages/district/widgets/district_tile.dart';
import 'package:bhulekh_up/widgets/ad_mob_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DistrictPage extends StatefulWidget {
  static const routeName = "/dashboard";

  const DistrictPage({super.key});

  @override
  State<DistrictPage> createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {
  late DistrictController controller;
  BannerAd? _banner;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<DistrictController>()
        ? Get.find<DistrictController>()
        : Get.put<DistrictController>(DistrictController(), permanent: true);
    _createBannerAd();
  }

  @override
  void dispose() {
    Get.delete<DistrictController>();
    super.dispose();
  }

  void _createBannerAd() {
    _banner = BannerAd(
        size: AdSize.banner,
        adUnitId: AdMobService.bannerAdUnitId!,
        listener: AdMobService.bannerAdListener,
        request: const AdRequest(nonPersonalizedAds: false))
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _banner == null
          ? const SizedBox()
          : Container(
              height: 52,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 12),
              child: AdWidget(
                ad: _banner!,
              ),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF365596),
                    Color(0xFF476ABB),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select your",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            "District",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "(जनपद चुने)",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      SvgPicture.asset(AppAssets.pointer),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return DistrictTile(controller.districts[index]);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.districts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
