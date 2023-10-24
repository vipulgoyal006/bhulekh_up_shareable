import 'package:admob_flutter/admob_flutter.dart';
import 'package:bhulekh_up/app_configs/app_asset.dart';
import 'package:bhulekh_up/data_models/district.dart';
import 'package:bhulekh_up/data_models/tehsil.dart';
import 'package:bhulekh_up/pages/khata_number/controller/fasil_controller.dart';
import 'package:bhulekh_up/pages/village/controller/village_controller.dart';
import 'package:bhulekh_up/pages/village/widget/village_tile.dart';
import 'package:bhulekh_up/widgets/app_loader.dart';
import 'package:bhulekh_up/widgets/sponsered_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VillagePage extends StatefulWidget {
  static const routeName = "/villagePage";

  const VillagePage({super.key});

  @override
  State<VillagePage> createState() => _VillagePageState();
}

class _VillagePageState extends State<VillagePage> {
  late VillageController controller;
  late District districtData;
  late Tehsil tehsilData;
  late FasliController fasliController;

  @override
  void initState() {
    super.initState();
    final map = Get.arguments as Map<String, dynamic>?;
    if (map != null) {
      districtData = map['district'];
      tehsilData = map['tehsil'];
    }
    controller = Get.isRegistered<VillageController>()
        ? Get.find<VillageController>()
        : Get.put<VillageController>(VillageController(), permanent: true);
    fasliController = Get.isRegistered<FasliController>()
        ? Get.find<FasliController>()
        : Get.put(FasliController());
    controller.selectedTehsil = tehsilData;
    controller.getVillage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SponsoredSection(size: AdmobBannerSize.BANNER),
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
                      Text(
                        "${districtData.districtName} - ${tehsilData.tehsilName}",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
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
                            "Village",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "(ग्राम का नाम)",
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
            controller.obx(
              (state) => state == null
                  ? const Center(
                      child: AppProgress(),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => VillageTile(state[index],
                          districtData: districtData, tehsilData: tehsilData),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state.length),
              onLoading: const Center(
                child: AppProgress(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
