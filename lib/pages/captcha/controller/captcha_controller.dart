import 'dart:developer';
import 'dart:io';

import 'package:bhulekh_up/pages/khata_number/controller/fasil_controller.dart';
import 'package:bhulekh_up/pages/khata_number/controller/khasraNum_controller.dart';
import 'package:bhulekh_up/pages/khata_number/controller/khata_controller.dart';
import 'package:bhulekh_up/pages/report_page/html_view_page.dart';
import 'package:bhulekh_up/pages/tehsil/controller/tehsil_controller.dart';
import 'package:bhulekh_up/pages/village/controller/village_controller.dart';
import 'package:bhulekh_up/widgets/app_buttons/app_primary_button.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CaptchaController extends GetxController {
  RxString htmlResponse = RxString('');
  late TehsilController tehsilController;
  late VillageController villageController;
  late FasliController fasliController;
  late KhasraNumController khasraNumController;
  late KhataController khataController;
  List<String> formattedCookies = [];
  final GlobalKey<AppPrimaryButtonState> buttonKey = GlobalKey();
  final TextEditingController captchacontroller = TextEditingController();
  Uint8List? imageFile;

  @override
  void dispose() {
    super.dispose();
    captchacontroller.dispose();
  }

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
    khasraNumController = Get.isRegistered<KhasraNumController>()
        ? Get.find<KhasraNumController>()
        : Get.put<KhasraNumController>(KhasraNumController(), permanent: true);
    khataController = Get.isRegistered<KhataController>()
        ? Get.find<KhataController>()
        : Get.put<KhataController>(KhataController(), permanent: true);
    getCookiesFromFirstApi();
  }

  convert() async {
    // Name is File Name that you want to give the file
    var targetPath = await _localPath;
    var targetFileName =
        "Khata_report${DateTime.now().millisecondsSinceEpoch}.pdf";

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlResponse.value, targetPath!, targetFileName);
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(generatedPdfFile.toString()),
    ));
  }

  Future<String?> get _localPath async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationSupportDirectory();
      } else {
        // if platform is android
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      print("Can-not get download folder path");
    }
    return directory?.path;
  }

  void getCookiesFromFirstApi() async {
    final dio.Dio dioInstance = dio.Dio();
    try {
      final response = await dioInstance.get('https://upbhulekh.gov.in/');

      if (response.statusCode == 200) {
        final headersMap = response.headers.map;

        if (headersMap.containsKey('set-cookie')) {
          final List<String>? cookies = headersMap['set-cookie'];

          for (String cookie in cookies!) {
            final cookieParts = cookie.split(';');
            final formattedCookie = cookieParts
                .where((part) => !part.trim().toLowerCase().startsWith('path='))
                .join(';');
            formattedCookies.add(formattedCookie);
          }
        } else {
          print('No cookies found in the response headers.');
        }
      } else {
        print(
            'Request to the first API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Uint8List> fetchImage() async {
    final cookieHeaderValue = formattedCookies.join('; ');
    final headers = {
      'Cookie': cookieHeaderValue,
    };
    final response = await http.get(Uri.parse('https://upbhulekh.gov.in/ldcap'),
        headers: headers);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<void> captchaMatch() async {
    final cookieHeaderValue = formattedCookies.join('; ');
    final headers = {
      'Cookie': cookieHeaderValue,
    };
    try {
      buttonKey.currentState?.showLoader();
      final response = await http.post(
        Uri.parse(
            'https://upbhulekh.gov.in/public/public_ror/action/captchamatch'),
        body: {
          "khata_number": khasraNumController.state?[0].khataNumber,
          "district_name": tehsilController.selectedDistrict.districtName,
          "district_code": tehsilController.selectedDistrict.districtCodeCensus,
          "tehsil_name": villageController.selectedTehsil.tehsilName,
          "tehsil_code": villageController.selectedTehsil.tehsilCodeCensus,
          "village_name": fasliController.selectedVillage?.vname,
          "village_code": fasliController.selectedVillage?.villageCodeCensus,
          "pargana_code": fasliController.selectedVillage?.parganaCodeNew,
          "fasli_code": fasliController.selectedFasliYear?.fasliYear ?? "",
          "fasli_name": fasliController.selectedFasliYear?.fasliYear ?? "",
          "captcha": captchacontroller.text
        },
        headers: headers,
      );
      if (response.statusCode == 200) {
        htmlResponse.value = response.body;
        print("sjjsdh ${htmlResponse.value.toString()}");
        if (htmlResponse.value.trim().contains("Captcha Not Matched")) {
          Get.dialog(
            SimpleDialog(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "captcha not matched",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "कैप्चा मेल नहीं खाता",
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
                        child: const Text(
                          "Ok",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        } else {
          Get.toNamed(HtmlViewPage.routeName);
        }
      }
    } catch (e, s) {
      log("ERROR", error: e, stackTrace: s);
    } finally {
      buttonKey.currentState?.hideLoader();
    }
  }
}
