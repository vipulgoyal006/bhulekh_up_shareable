import 'package:bhulekh_up/app_configs/app_colors.dart';
import 'package:bhulekh_up/data_models/khasra_num.dart';
import 'package:bhulekh_up/pages/captcha/controller/captcha_controller.dart';
import 'package:bhulekh_up/pages/captcha/get_captcha.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KhasraNumberTile extends StatelessWidget {
  KhasraNumberTile(
    this.data, {
    Key? key,
  }) : super(key: key);
  final KhasraNumRes data;
  final captchaController = Get.put(CaptchaController());

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // controller.fetchKhasraReport(data);
          // captchaController.fetchCaptchCode(data);
          Get.toNamed(
            EnterCaptchaPage.routeName,
          );
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
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.primary.withOpacity(0.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
