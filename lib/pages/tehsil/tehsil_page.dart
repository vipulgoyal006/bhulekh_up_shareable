import 'package:bhulekh_up/app_configs/app_asset.dart';
import 'package:bhulekh_up/app_configs/app_colors.dart';
import 'package:bhulekh_up/data_models/district.dart';
import 'package:bhulekh_up/data_models/tehsil.dart';
import 'package:bhulekh_up/pages/tehsil/controller/tehsil_controller.dart';
import 'package:bhulekh_up/pages/tehsil/widget/tehsil_tile.dart';
import 'package:bhulekh_up/widgets/ad_mob_services.dart';
import 'package:bhulekh_up/widgets/app_error_widget.dart';
import 'package:bhulekh_up/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TehsilPage extends StatefulWidget {
  static const routeName = "/tehsilPage";

  const TehsilPage({
    super.key,
  });

  @override
  State<TehsilPage> createState() => _TehsilPageState();
}

class _TehsilPageState extends State<TehsilPage> {
  late TehsilController controller;
  late District districtData;
  BannerAd? _banner;

  @override
  void initState() {
    super.initState();
    final map = Get.arguments as Map<String, dynamic>?;
    if (map != null) {
      districtData = map['districtData'];
    }
    controller = Get.isRegistered<TehsilController>()
        ? Get.find<TehsilController>()
        : Get.put<TehsilController>(TehsilController(), permanent: true);
    controller.selectedDistrict = districtData;
    controller.getTehsil();
    _createBannerAd();
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
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(districtData.districtName,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
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
                            "Tehsil",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "(तहसील चुने)",
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
              child: controller.obx(
                (state) => state == null
                    ? const Center(
                        child: AppProgress(),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => TehsilTile(
                              state[index],
                              districtData: districtData,
                              index: index,
                            ),
                        separatorBuilder: (context, index) =>
                            Divider(color: AppColors.divider.withOpacity(0.3)),
                        itemCount: state.length),
                onLoading: const Center(
                  child: AppProgress(),
                ),
                onError: (e) => AppErrorWidget(
                  title: e ?? 'Some error occurred',
                  onRetry: controller.getTehsil,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
