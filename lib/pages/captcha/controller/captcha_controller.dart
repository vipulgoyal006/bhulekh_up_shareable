import 'dart:developer';

import 'package:bhulekh_up/data_models/khasra_num.dart';
import 'package:bhulekh_up/pages/captcha/get_captcha.dart';
import 'package:bhulekh_up/pages/khata_number/controller/fasil_controller.dart';
import 'package:bhulekh_up/pages/tehsil/controller/tehsil_controller.dart';
import 'package:bhulekh_up/pages/village/controller/village_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CaptchaController extends GetxController {
  RxString getCaptcha = RxString('');
  late TehsilController tehsilController;
  late VillageController villageController;
  late FasliController fasliController;

  @override
  void onInit() {
    super.onInit();
    tehsilController = Get.isRegistered<TehsilController>()
        ? Get.find<TehsilController>()
        : Get.put<TehsilController>(TehsilController(), permanent: true);
    villageController = Get.isRegistered<VillageController>()
        ? Get.find<VillageController>()
        : Get.put<VillageController>(VillageController(), permanent: true);
    fasliController = Get.isRegistered<FasliController>()
        ? Get.find<FasliController>()
        : Get.put<FasliController>(FasliController(), permanent: true);
  }

  Future<void> fetchCaptchCode(KhasraNumRes data) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://upbhulekh.gov.in/public/public_ror/action/capImage.jsp'),
        body: {
          "khata_number": data.khataNumber,
          "district_name": tehsilController.selectedDistrict.districtName,
          "district_code": tehsilController.selectedDistrict.districtCodeCensus,
          "tehsil_name": villageController.selectedTehsil.tehsilName,
          "tehsil_code": villageController.selectedTehsil.tehsilCodeCensus,
          "village_name": fasliController.selectedVillage.vname,
          "village_code": fasliController.selectedVillage.villageCodeCensus,
          "pargana_name": fasliController.selectedVillage.pname,
          "pargana_code": fasliController.selectedVillage.parganaCodeNew,
          "fasli_code": fasliController.selectedFasliYear!.fasliYear,
          "fasli_name": fasliController.selectedFasliYear!.fasliYear
        },
      );
      if (response.statusCode == 200) {
        getCaptcha.value = response.body;
        Get.toNamed(EnterCaptchaPage.routeName);
      } else {
        getCaptcha.value = 'Failed to fetch data: ${response.statusCode}';
      }
    } catch (e, s) {
      log("Error", error: e, stackTrace: s);
    }
  }
}
