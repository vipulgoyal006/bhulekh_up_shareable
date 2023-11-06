import 'dart:convert';
import 'dart:developer';
import 'package:bhulekh_up/data_models/district.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DistrictController extends GetxController {
  late ScrollController scrollController;
  OverlayEntry? overlayEntry;

  final List<District> districts = [
    District(
        districtName: "अमरोहा",
        districtCodeCensus: "137",
        districtNameEnglish: "Amroha"),
    District(
        districtName: "अमेठी",
        districtCodeCensus: "203",
        districtNameEnglish: "Amethi"),
    District(
        districtName: "अम्बेडकरनगर",
        districtCodeCensus: "178",
        districtNameEnglish: "Ambedkarnagar"),
    District(
        districtName: "अयोध्या",
        districtCodeCensus: "177",
        districtNameEnglish: "Ayodhya"),
    District(
        districtName: "अलीगढ़",
        districtCodeCensus: "143",
        districtNameEnglish: "Aligarh"),
    District(
        districtName: "आगरा",
        districtCodeCensus: "146",
        districtNameEnglish: "Agra"),
    District(
        districtName: "आजमगढ",
        districtCodeCensus: "191",
        districtNameEnglish: "Azamgarh"),
    District(
        districtName: "इटावा",
        districtCodeCensus: "161",
        districtNameEnglish: "Etawah"),
    District(
        districtName: "उन्नाव",
        districtCodeCensus: "156",
        districtNameEnglish: "Unnao"),
    District(
        districtName: "एटा",
        districtCodeCensus: "201",
        districtNameEnglish: "Etah"),
    District(
        districtName: "औरैया",
        districtCodeCensus: "162",
        districtNameEnglish: "Auraya"),
    District(
        districtName: "कन्वौज",
        districtCodeCensus: "160",
        districtNameEnglish: "Kannauj"),
    District(
        districtName: "कानपुर देहात",
        districtCodeCensus: "163",
        districtNameEnglish: "Kanpurdehat"),
    District(
        districtName: "कानपुर नगर",
        districtCodeCensus: "164",
        districtNameEnglish: "Kanpurnagar"),
    District(
        districtName: "कासगंज",
        districtCodeCensus: "202",
        districtNameEnglish: "Kasganj"),
    District(
        districtName: "कुशीनगर",
        districtCodeCensus: "189",
        districtNameEnglish: "Kushinagar"),
    District(
        districtName: "कौशाम्बी",
        districtCodeCensus: "174",
        districtNameEnglish: "Kaushambhi"),
    District(
        districtName: "खीरी",
        districtCodeCensus: "153",
        districtNameEnglish: "Kheri"),
    District(
        districtName: "गाजियाबाद",
        districtCodeCensus: "140",
        districtNameEnglish: "Ghaziabad"),
    District(
        districtName: "गाजीपुर",
        districtCodeCensus: "195",
        districtNameEnglish: "Ghazipur"),
    District(
        districtName: "गोरखपुर",
        districtCodeCensus: "188",
        districtNameEnglish: "Gorakhpur"),
    District(
        districtName: "गोंडा",
        districtCodeCensus: "183",
        districtNameEnglish: "Gonda"),
    District(
        districtName: "गौतम बुद्ध नगर",
        districtCodeCensus: "141",
        districtNameEnglish: "Gbnagar"),
    District(
        districtName: "चन्दौली",
        districtCodeCensus: "196",
        districtNameEnglish: "Chandauli"),
    District(
        districtName: "चित्रकूट",
        districtCodeCensus: "171",
        districtNameEnglish: "Chitrakoot"),
    District(
        districtName: "जालौन",
        districtCodeCensus: "165",
        districtNameEnglish: "Jalaun"),
    District(
        districtName: "जौनपुर",
        districtCodeCensus: "194",
        districtNameEnglish: "Jaunpur"),
    District(
        districtName: "झांसी",
        districtCodeCensus: "166",
        districtNameEnglish: "Jhansi"),
    District(
        districtName: "देवरिया",
        districtCodeCensus: "190",
        districtNameEnglish: "Deoria"),
    District(
        districtName: "पीलीभीत",
        districtCodeCensus: "151",
        districtNameEnglish: "Pilibhit"),
    District(
        districtName: "प्रतापगढ",
        districtCodeCensus: "173",
        districtNameEnglish: "Pratapgarh"),
    District(
        districtName: "प्रयागराज",
        districtCodeCensus: "175",
        districtNameEnglish: "Prayagraj"),
    District(
        districtName: "फतेहपुर",
        districtCodeCensus: "172",
        districtNameEnglish: "Fatehpur"),
    District(
        districtName: "फर्रूखाबाद",
        districtCodeCensus: "159",
        districtNameEnglish: "Farrukhabad"),
    District(
        districtName: "फिरोजाबाद",
        districtCodeCensus: "147",
        districtNameEnglish: "Firozabad"),
    District(
        districtName: "बदायूँ",
        districtCodeCensus: "149",
        districtNameEnglish: "Badaun"),
    District(
        districtName: "बरेली",
        districtCodeCensus: "150",
        districtNameEnglish: "Bareilly"),
    District(
        districtName: "बलरामपुर",
        districtCodeCensus: "182",
        districtNameEnglish: "Balrampur"),
    District(
        districtName: "बलिया",
        districtCodeCensus: "193",
        districtNameEnglish: "Ballia"),
    District(
        districtName: "बस्ती",
        districtCodeCensus: "185",
        districtNameEnglish: "Basti"),
    District(
        districtName: "बहराइच",
        districtCodeCensus: "180",
        districtNameEnglish: "Behraich"),
    District(
        districtName: "बागपत",
        districtCodeCensus: "139",
        districtNameEnglish: "Bagpat"),
    District(
        districtName: "बाराबंकी",
        districtCodeCensus: "176",
        districtNameEnglish: "Barabanki"),
    District(
        districtName: "बाँदा",
        districtCodeCensus: "170",
        districtNameEnglish: "Banda"),
    District(
        districtName: "बिजनौर",
        districtCodeCensus: "134",
        districtNameEnglish: "Bijnor"),
    District(
        districtName: "बुलन्द शहर",
        districtCodeCensus: "142",
        districtNameEnglish: "Bulandshahar"),
    District(
        districtName: "भदोही",
        districtCodeCensus: "198",
        districtNameEnglish: "Bhadohi"),
    District(
        districtName: "मऊ",
        districtCodeCensus: "192",
        districtNameEnglish: "Mau"),
    District(
        districtName: "मथुरा",
        districtCodeCensus: "145",
        districtNameEnglish: "Mathura"),
    District(
        districtName: "महाराजगंज",
        districtCodeCensus: "187",
        districtNameEnglish: "Maharajganj"),
    District(
        districtName: "महोबा",
        districtCodeCensus: "169",
        districtNameEnglish: "Mahoba"),
    District(
        districtName: "मिर्जापुर",
        districtCodeCensus: "199",
        districtNameEnglish: "Mirzapur"),
    District(
        districtName: "मुजफफर नगर",
        districtCodeCensus: "133",
        districtNameEnglish: "Muzaffarnagar"),
    District(
        districtName: "मुरादाबाद",
        districtCodeCensus: "135",
        districtNameEnglish: "Moradabad"),
    District(
        districtName: "मेरठ",
        districtCodeCensus: "138",
        districtNameEnglish: "Meerut"),
    District(
        districtName: "मैनपुरी",
        districtCodeCensus: "148",
        districtNameEnglish: "Mainpuri"),
    District(
        districtName: "रामपुर",
        districtCodeCensus: "136",
        districtNameEnglish: "Rampur"),
    District(
        districtName: "रायबरेली",
        districtCodeCensus: "158",
        districtNameEnglish: "Raebareli"),
    District(
        districtName: "लखनऊ",
        districtCodeCensus: "157",
        districtNameEnglish: "Lucknow"),
    District(
        districtName: "ललितपुर",
        districtCodeCensus: "167",
        districtNameEnglish: "Lalitpur"),
    District(
        districtName: "वाराणसी",
        districtCodeCensus: "197",
        districtNameEnglish: "Varanasi"),
    District(
        districtName: "शामली",
        districtCodeCensus: "206",
        districtNameEnglish: "Shamli"),
    District(
        districtName: "शाहजहांपुर",
        districtCodeCensus: "152",
        districtNameEnglish: "Shahjahanpur"),
    District(
        districtName: "श्रावस्ती",
        districtCodeCensus: "181",
        districtNameEnglish: "Shravasti"),
    District(
        districtName: "सन्तकबीर नगर",
        districtCodeCensus: "186",
        districtNameEnglish: "Santkabirnagar"),
    District(
        districtName: "सम्भल",
        districtCodeCensus: "205",
        districtNameEnglish: "Sambhal"),
    District(
        districtName: "सहारनपुर",
        districtCodeCensus: "132",
        districtNameEnglish: "Saharanpur"),
    District(
        districtName: "सिद्धार्थनगर",
        districtCodeCensus: "184",
        districtNameEnglish: "Sidharthnagar"),
    District(
        districtName: "सीतापुर",
        districtCodeCensus: "154",
        districtNameEnglish: "Sitapur"),
    District(
        districtName: "सुल्तानपुर",
        districtCodeCensus: "179",
        districtNameEnglish: "Sultanpur"),
    District(
        districtName: "सोनभद्र",
        districtCodeCensus: "200",
        districtNameEnglish: "Sonbhadra"),
    District(
        districtName: "हमीरपुर",
        districtCodeCensus: "168",
        districtNameEnglish: "Hamirpur"),
    District(
        districtName: "हरदोई",
        districtCodeCensus: "155",
        districtNameEnglish: "Hardoi"),
    District(
        districtName: "हाथरस",
        districtCodeCensus: "144",
        districtNameEnglish: "Hathras"),
    District(
      districtName: "हापुड़",
      districtCodeCensus: "204",
      districtNameEnglish: "Hapur",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
    // makeApiCall();
  }

  // Future<void> makeApiCall() async {
  //   try {
  //     change(null, status: RxStatus.loading());
  //     final url = Uri.parse(
  //         "https://upbhulekh.gov.in/public/public_ror/action/public_action.jsp");
  //     final data = {
  //       "act": "fillDistrict",
  //     };
  //     final response = await http.post(url, body: data);
  //
  //     if (response.statusCode == 200) {
  //       final responseData = response.body.toString();
  //       final jsonData = json.decode(responseData);
  //       final users =
  //       List<District>.from(jsonData.map((x) => District.fromJson(x)));
  //       change(users,
  //           status: users.isEmpty ? RxStatus.empty() : RxStatus.success());
  //     } else {
  //       throw "Server Unreachable";
  //     }
  //   } catch (e, s) {
  //     log("error", error: e, stackTrace: s);
  //     change(null, status: RxStatus.error(e.toString()));
  //   }
  // }

  _scrollListener() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
