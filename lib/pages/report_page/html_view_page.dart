import 'package:bhulekh_up/app_configs/app_colors.dart';
import 'package:bhulekh_up/pages/captcha/controller/captcha_controller.dart';
import 'package:bhulekh_up/pages/district/district_page.dart';
import 'package:bhulekh_up/widgets/app_buttons/app_back_button.dart';
import 'package:bhulekh_up/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlViewPage extends StatefulWidget {
  static const routeName = '/HtmlViewPage';

  const HtmlViewPage({super.key});

  @override
  _HtmlViewPageState createState() => _HtmlViewPageState();
}

class _HtmlViewPageState extends State<HtmlViewPage> {
  late CaptchaController controller;
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<CaptchaController>()
        ? Get.find<CaptchaController>()
        : Get.put<CaptchaController>(CaptchaController(), permanent: true);
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(controller.htmlResponse.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          // PermissionStatus statuses =
          //     await Permission.storage.request();
          if (true) {
            controller.convert();
          }
        },
        child: const Icon(
          Icons.download_rounded,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: AppBackButton(
          color: Colors.white,
          onPressed: () {
            Get.offAllNamed(DistrictPage.routeName);
          },
        ),
        title: const Text(
          "Report",
          style: TextStyle(color: Colors.white),
        ),
        titleSpacing: 0,
      ),
      body: controller.htmlResponse.isEmpty == true
          ? const AppProgress()
          : WebViewWidget(
              controller: webViewController,
            ),
    );
  }
}
