import 'package:bhulekh_up/data_models/khataName.dart';
import 'package:bhulekh_up/pages/captcha/get_captcha.dart';
import 'package:bhulekh_up/pages/khata_number/controller/khata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KhataNumberTile extends StatelessWidget {
  KhataNumberTile(this.khataName, {Key? key}) : super(key: key);
  final KhataName khataName;
  final controller = Get.put(KhataController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(EnterCaptchaPage.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.channelType == 2
                      ? Text(
                          "${khataName.name} : ${khataName.father}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff676F75),
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "${khataName.khataNumber} - ${khataName.name} - ${khataName.father}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff676F75),
                              fontWeight: FontWeight.bold),
                        ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}
