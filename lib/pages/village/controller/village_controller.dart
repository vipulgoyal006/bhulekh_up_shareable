import 'dart:convert';
import 'dart:developer';

import 'package:bhulekh_up/data_models/fasli_year.dart';
import 'package:bhulekh_up/data_models/tehsil.dart';
import 'package:bhulekh_up/data_models/village.dart';
import 'package:bhulekh_up/pages/khata_number/controller/fasil_controller.dart';
import 'package:bhulekh_up/pages/tehsil/controller/tehsil_controller.dart';
import 'package:bhulekh_up/widgets/ad_mob_services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

class VillageController extends GetxController with StateMixin<List<Village>> {
  late List<FasliYear> fasliYear;
  late Tehsil selectedTehsil;
  late TehsilController tehsilController;
  late FasliController fasliController;
  InterstitialAd? _interstitialAd;

  @override
  void onInit() {
    super.onInit();
    tehsilController = Get.isRegistered<TehsilController>()
        ? Get.find<TehsilController>()
        : Get.put<TehsilController>(TehsilController(), permanent: true);
    fasliController = Get.isRegistered<FasliController>()
        ? Get.find<FasliController>()
        : Get.put(FasliController());
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createInterstitialAd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _createInterstitialAd();
      });
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialUnitAdId!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) => _interstitialAd = ad,
            onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null));
  }

  Future<void> getVillage() async {
    try {
      change(null, status: RxStatus.loading());
      final url = Uri.parse(
          'https://upbhulekh.gov.in/public/public_ror/action/public_action.jsp');
      final formData = http.MultipartRequest('POST', url);

      formData.fields.addAll({
        "act": "fillVillageGeneral",
        "district_code": tehsilController.selectedDistrict.districtCodeCensus,
        "tehsil_code": selectedTehsil.tehsilCodeCensus,
      });

      final response = await formData.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = json.decode(responseData);
        final users =
            List<Village>.from(jsonData.map((x) => Village.fromJson(x)));
        change(users,
            status: users.isEmpty ? RxStatus.empty() : RxStatus.success());
      } else {
        print("API Error: ${response.statusCode}");
      }
    } catch (e, s) {
      log("Error", error: e, stackTrace: s);
    }
  }
}
