import 'package:bhulekh_up/data_models/district.dart';
import 'package:bhulekh_up/data_models/tehsil.dart';
import 'package:bhulekh_up/pages/village/controller/village_controller.dart';
import 'package:bhulekh_up/pages/village/village.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TehsilTile extends StatelessWidget {
  TehsilTile(this.data, {Key? key, required this.districtData})
      : super(key: key);
  final District districtData;
  final Tehsil data;
  final controller = Get.put(VillageController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(VillagePage.routeName,
            arguments: {"district": districtData, "tehsil": data});
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
                    "${data.tehsilName} (${data.tehsilNameEnglish})",
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
