import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bhulekh_up/data_models/district.dart';
import 'package:bhulekh_up/data_models/rest_error.dart';
import 'package:bhulekh_up/data_models/tehsil.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TehsilController extends GetxController with StateMixin<List<Tehsil>> {
  late District selectedDistrict;

  Future<void> getTehsil() async {
    try {
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
        throw "Server Unreachable";
      }
    } on SocketException catch (e) {
      throw NoInternetError();
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(e.response!.data);
          if (restError.code == 401) {}
          throw restError;
        }
      } else {
        throw e.toString();
      }
    }
  }
}
