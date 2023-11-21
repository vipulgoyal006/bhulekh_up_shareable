import 'dart:io';

import 'package:bhulekh_up/app_configs/app_colors.dart';
import 'package:bhulekh_up/pages/captcha/controller/captcha_controller.dart';
import 'package:bhulekh_up/pages/district/district_page.dart';
import 'package:bhulekh_up/pages/khata_number/search_khata_number.dart';
import 'package:bhulekh_up/widgets/alert_dialog.dart';
import 'package:bhulekh_up/widgets/app_buttons/app_back_button.dart';
import 'package:bhulekh_up/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
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
          PermissionStatus statuses = await Permission.storage.request();
          if (statuses.isGranted) {
            controller.screenshotController
                .capture(pixelRatio: 2)
                .then((image) async {
              setState(() {
                controller.imageFile = image;
              });
              final Directory directory = await getTemporaryDirectory();
              const fileName = "Khata_Report.jpeg";
              // final fileName =
              //     "${controller.userController.state?.storeDetails?.storeName ?? ''} qr.png";
              const String filePath = "/storage/emulated/0/Download";
              controller.screenshotController
                  .captureAndSave(filePath, fileName: fileName)
                  .then((value) {
                showAppAlertDialog(
                        title: "Report Code Downloaded",
                        description: "Your Image is saved to $fileName",
                        positiveText: "View")
                    .then((value) {
                  if (value == true) {
                    OpenFilex.open(filePath + "/" + fileName);
                  }
                });
              });
              // print("dkdkdkkd${controller.imageFile}");
            }).catchError((onError) {
              print("ERROR ${onError}");
            });
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
            Get.offAllNamed(SearchKhataNumber.routeName);
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
          : Screenshot(
              controller: controller.screenshotController,
              child: WebViewWidget(
                controller: webViewController,
              ),
            ),
    );
  }
}
