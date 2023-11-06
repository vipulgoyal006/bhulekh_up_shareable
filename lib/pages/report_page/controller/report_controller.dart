import 'package:bhulekh_up/data_models/khasra_num.dart';
import 'package:bhulekh_up/data_models/khataName.dart';
import 'package:bhulekh_up/pages/khata_number/controller/fasil_controller.dart';
import 'package:bhulekh_up/pages/report_page/html_view_page.dart';
import 'package:bhulekh_up/pages/tehsil/controller/tehsil_controller.dart';
import 'package:bhulekh_up/pages/village/controller/village_controller.dart';
import 'package:bhulekh_up/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {
  RxString htmlResponse = RxString('');
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

  Future<void> fetchReport(KhataName khataName) async {
    final response = await http.post(
      Uri.parse(
          'https://upbhulekh.gov.in/public/public_ror/public_ror_report.jsp'),
      body: {
        'khata_number': khataName.khataNumber,
        'district_name': tehsilController.selectedDistrict.districtName,
        'district_code': tehsilController.selectedDistrict.districtCodeCensus,
        'tehsil_name': villageController.selectedTehsil.tehsilName,
        'tehsil_code': villageController.selectedTehsil.tehsilCodeCensus,
        'village_name': fasliController.selectedVillage.vname,
        'village_code': fasliController.selectedVillage.villageCodeCensus,
        'fasli_code': fasliController.selectedFasliYear!.fasliYear,
      },
    );

    if (response.statusCode == 200) {
      htmlResponse.value = response.body;
      if (htmlResponse.isNotEmpty) {
        Get.toNamed(HtmlViewPage.routeName);
      } else {
        Get.dialog(SimpleDialog(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "No Data Found",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "(कोई डेटा मौजूद नहीं)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 60,
                  height: 40,
                  child: AppPrimaryButton(
                    color: Color(0xFF355495),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Ok"),
                  ),
                )
              ],
            ),
          ],
        ));
      }
    } else {
      htmlResponse.value = 'Failed to fetch data: ${response.statusCode}';
    }
  }

  Future<void> fetchKhasraReport(KhasraNumRes data) async {
    final response = await http.post(
      Uri.parse(
          'https://upbhulekh.gov.in/public/public_ror/public_ror_report.jsp'),
      body: {
        'khata_number': data.khataNumber,
        'district_name': tehsilController.selectedDistrict.districtName,
        'district_code': tehsilController.selectedDistrict.districtCodeCensus,
        'tehsil_name': villageController.selectedTehsil.tehsilName,
        'tehsil_code': villageController.selectedTehsil.tehsilCodeCensus,
        'village_name': fasliController.selectedVillage.vname,
        'village_code': fasliController.selectedVillage.villageCodeCensus,
        'fasli_code': fasliController.selectedFasliYear!.fasliYear,
      },
    );

    if (response.statusCode == 200) {
      htmlResponse.value = response.body;
      if (htmlResponse.isNotEmpty) {
        Get.toNamed(HtmlViewPage.routeName);
      } else {
        Get.dialog(SimpleDialog(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "No Data Found",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "(कोई डेटा मौजूद नहीं)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 60,
                  height: 40,
                  child: AppPrimaryButton(
                    color: Color(0xFF355495),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Ok"),
                  ),
                )
              ],
            ),
          ],
        ));
      }
    } else {
      htmlResponse.value = 'Failed to fetch data: ${response.statusCode}';
    }
  }
}
