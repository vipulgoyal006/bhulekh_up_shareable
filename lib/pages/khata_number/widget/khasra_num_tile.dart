import 'package:bhulekh_up/data_models/khasra_num.dart';
import 'package:bhulekh_up/pages/report_page/controller/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KhasraNumberTile extends StatelessWidget {
  KhasraNumberTile(
    this.data, {
    Key? key,
  }) : super(key: key);
  final KhasraNumRes data;
  final controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.fetchKhasraReport(data);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.khasraNumber} - ${data.uniqueCode}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff676F75),
                        fontWeight: FontWeight.bold),
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
