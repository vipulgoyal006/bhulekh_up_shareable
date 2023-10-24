import 'package:admob_flutter/admob_flutter.dart';
import 'package:bhulekh_up/pages/khata_number/controller/khata_controller.dart';
import 'package:bhulekh_up/pages/khata_number/widget/khata_number_tile.dart';
import 'package:bhulekh_up/widgets/app_error_widget.dart';
import 'package:bhulekh_up/widgets/app_loader.dart';
import 'package:bhulekh_up/widgets/sponsered_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KhataNumberPage extends StatefulWidget {
  static const routeName = "/khataNumberPage";

  const KhataNumberPage({super.key});

  @override
  State<KhataNumberPage> createState() => _KhataNumberPageState();
}

class _KhataNumberPageState extends State<KhataNumberPage> {
  late KhataController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<KhataController>()
        ? Get.find<KhataController>()
        : Get.put<KhataController>(KhataController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SponsoredSection(size: AdmobBannerSize.BANNER),
      appBar: AppBar(
        backgroundColor: const Color(0xFF476ABB),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "नाम चुनें",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: controller.obx(
          (state) => state == null
              ? const Center(
                  child: AppErrorWidget(),
                )
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: KhataNumberTile(
                          state[index],
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.length),
          onLoading: const Center(
            child: AppProgress(),
          ),
          onEmpty: const AppEmptyWidget(
            textColor: Colors.black,
          ),
          onError: (e) => AppErrorWidget(
            title: e.toString(),
            onRetry: () {
              controller.getKhataNumberByName();
            },
          ),
        ),
      ),
    );
  }
}
