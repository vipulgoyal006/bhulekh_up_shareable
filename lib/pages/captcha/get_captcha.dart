import 'package:bhulekh_up/pages/captcha/controller/captcha_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EnterCaptchaPage extends StatefulWidget {
  static const routeName = "/getCaptcha";

  const EnterCaptchaPage({super.key});

  @override
  State<EnterCaptchaPage> createState() => _EnterCaptchaPageState();
}

class _EnterCaptchaPageState extends State<EnterCaptchaPage> {
  late WebViewController webViewController;
  late CaptchaController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<CaptchaController>()
        ? Get.find<CaptchaController>()
        : Get.put<CaptchaController>(CaptchaController(), permanent: true);
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(controller.getCaptcha.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
