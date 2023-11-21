import 'package:bhulekh_up/app_configs/app_colors.dart';
import 'package:bhulekh_up/app_configs/app_decorations.dart';
import 'package:bhulekh_up/app_configs/app_validators.dart';
import 'package:bhulekh_up/data_models/khasra_num.dart';
import 'package:bhulekh_up/pages/captcha/controller/captcha_controller.dart';
import 'package:bhulekh_up/widgets/app_buttons/app_back_button.dart';
import 'package:bhulekh_up/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class EnterCaptchaPage extends StatefulWidget {
  static const routeName = "/getCaptcha";

  const EnterCaptchaPage({super.key});

  @override
  State<EnterCaptchaPage> createState() => _EnterCaptchaPageState();
}

class _EnterCaptchaPageState extends State<EnterCaptchaPage> {
  late WebViewController webViewController;
  late CaptchaController controller;
  late KhasraNumRes khasraData;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<CaptchaController>()
        ? Get.find<CaptchaController>()
        : Get.put<CaptchaController>(CaptchaController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: AppBackButton(
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              FutureBuilder<Uint8List>(
                future: controller.fetchImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Center(
                        child: Image.memory(
                          snapshot.data!,
                          width: 400,
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  controller: controller.captchacontroller,
                  maxLength: 6,
                  validator: (data) => AppFormValidators.validateEmpty(data),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  // onSaved: controller.onCommunityNameSaved,
                  decoration: AppDecorations.textFieldOutlinedDecoration()
                      .copyWith(hintText: "Enter Captcha"),
                ),
              ),
              const SizedBox(height: 20),
              AppPrimaryButton(
                key: controller.buttonKey,
                width: 200,
                onPressed: () {
                  controller.captchaMatch();
                },
                color: AppColors.primary,
                child: const Text(
                  "Verify",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
