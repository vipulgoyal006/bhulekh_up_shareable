import 'dart:convert';
import 'dart:developer';

import 'package:bhulekh_up/data_models/fasli_year.dart';
import 'package:bhulekh_up/data_models/village.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FasliController extends GetxController with StateMixin<List<FasliYear>> {
  FasliYear? selectedFasliYear;
  List<FasliYear>? fasilYearList;
  late Village selectedVillage;

  @override
  void onInit() {
    super.onInit();
    getFasliYear();
  }

  onFasliYearSaved(FasliYear? newValue) {
    selectedFasliYear = newValue;
  }

  Future<void> getFasliYear() async {
    try {
      print("villageCode ${selectedVillage.villageCodeCensus}");
      change(null, status: RxStatus.loading());
      final url = Uri.parse(
          'https://upbhulekh.gov.in/public/public_ror/action/public_action.jsp');
      final formData = http.MultipartRequest('POST', url);

      formData.fields.addAll({
        "act": "fillfasliyear",
        "village_code": selectedVillage.villageCodeCensus,
      });

      final response = await formData.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = json.decode(responseData);
        fasilYearList =
            List<FasliYear>.from(jsonData.map((x) => FasliYear.fromJson(x)));
        change(fasilYearList,
            status: fasilYearList!.isNotEmpty
                ? RxStatus.success()
                : RxStatus.empty());
        print("Response $jsonData");
      } else {
        print("API Error: ${response.statusCode}");
      }
    } catch (e, s) {
      log("Error", error: e, stackTrace: s);
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
