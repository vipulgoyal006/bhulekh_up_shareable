import 'package:bhulekh_up/data_models/district.dart';
import 'package:bhulekh_up/data_models/tehsil.dart';
import 'package:bhulekh_up/data_models/village.dart';
import 'package:bhulekh_up/pages/khata_number/controller/fasil_controller.dart';
import 'package:bhulekh_up/pages/khata_number/search_khata_number.dart';
import 'package:bhulekh_up/pages/village/controller/village_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VillageTile extends StatelessWidget {
  VillageTile(
    this.data, {
    Key? key,
    required this.districtData,
    required this.tehsilData,
  }) : super(key: key);
  final Village data;
  final District districtData;
  final Tehsil tehsilData;
  final controller = Get.put(VillageController());
  final fasliController = Get.put(FasliController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(SearchKhataNumber.routeName, arguments: {
          "villageData": data,
          "districtData": districtData,
          "tehsilData": tehsilData
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.vname} (${data.vnameEng})",
                    style: const TextStyle(
                        color: Color(0xff676F75), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
