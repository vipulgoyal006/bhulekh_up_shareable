import 'package:bhulekh_up/data_models/district.dart';
import 'package:bhulekh_up/pages/tehsil/controller/tehsil_controller.dart';
import 'package:bhulekh_up/pages/tehsil/tehsil_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DistrictTile extends StatelessWidget {
  DistrictTile(this.districtData, {Key? key, required this.index})
      : super(key: key);
  final District districtData;
  final int index;
  final controller = Get.put(TehsilController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(TehsilPage.routeName, arguments: {
          "districtData": districtData,
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
        child: Row(
          children: [
            Text(
              "(${index + 1})",
              style: const TextStyle(
                  color: Color(0xff676F75), fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Text(
              "${districtData.districtName} (${districtData.districtNameEnglish})",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Color(0xff676F75),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
