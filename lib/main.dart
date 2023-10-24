import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bhulekh_up/app_configs/app_pages_routes.dart';
import 'package:bhulekh_up/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_portal/flutter_portal.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Portal(
      child: GetMaterialApp(
        title: 'UP Bhulekh',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        // localizationsDelegates: const [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        initialRoute: SplashPage.routeName,
        getPages: AppPages.pages,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
