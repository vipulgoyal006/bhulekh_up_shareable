import 'dart:convert';
import 'dart:developer';

import 'package:bhulekh_up/data_models/district.dart';
import 'package:bhulekh_up/data_models/tehsil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TehsilController extends GetxController with StateMixin<List<Tehsil>> {
  late District selectedDistrict;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getTehsil() async {
    try {
      print("object ${selectedDistrict.districtCodeCensus}");
      change(null, status: RxStatus.loading());
      final url = Uri.parse(
          'https://upbhulekh.gov.in/public/public_ror/action/public_action.jsp');
      final formData = http.MultipartRequest('POST', url);

      formData.fields.addAll({
        "act": "fillTehsil",
        "district_code": selectedDistrict.districtCodeCensus,
      });

      final response = await formData.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = json.decode(responseData);
        final users =
            List<Tehsil>.from(jsonData.map((x) => Tehsil.fromJson(x)));
        change(users,
            status: users.isEmpty ? RxStatus.empty() : RxStatus.success());
      } else {
        print("API Error: ${response.statusCode}");
      }
    } catch (e, s) {
      log("error", error: e, stackTrace: s);
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
