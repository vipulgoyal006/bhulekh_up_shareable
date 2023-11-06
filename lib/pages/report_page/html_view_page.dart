import 'dart:convert';

import 'package:bhulekh_up/pages/report_page/controller/report_controller.dart';
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
  late ReportController controller;
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<ReportController>()
        ? Get.find<ReportController>()
        : Get.put<ReportController>(ReportController(), permanent: true);
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(controller.htmlResponse.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Report"),
          titleSpacing: 0,
        ),
        body: WebViewWidget(
          controller: webViewController,
        ));
  }
}
