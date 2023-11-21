import 'package:flutter/material.dart';

mixin AppColors {
  static const brightBackground = Color(0xfff8f5f9);
  static const darkBackground = Color(0xff000000);
  static const borderColor = Color(0xffBDBDBD);
  static const divider = Color(0xffC4C3C3);
  static const darkGrey = Color(0xff676F75);
  static const subtitleGrey = Color(0xff828282);
  static const lightGrey = Color(0xffA4A4A4);
  static const descriptionText = Color(0xff575757);
  static const textColor = Color(0xff252525);
  static const appBarTextColor = Color(0xff130F26);
  static const gray = Color(0xffE2E2E2);
  static const ownChat = Color(0xFFE9E6EE);
  static const primary = Color(0xFF355395);

  static const MaterialColor brightPrimary =
      MaterialColor(brightPrimaryValue, <int, Color>{
    50: Color(0xFFE6F3FC),
    100: Color(0xFFC3E2F8),
    200: Color(0xFFA0D0F4),
    300: Color(0xFF7FBEEF),
    400: Color(0xFF69AFEB),
    500: Color(brightPrimaryValue),
    600: Color(0xFF5294DA),
    700: Color(0xFF4982C7),
    800: Color(0xFF4271B5),
    900: Color(0xFF355395),
  });
  static const int brightPrimaryValue = 0xFF5AA2E8;

  static const MaterialColor darkPrimary =
      MaterialColor(darkPrimaryPrimaryValue, <int, Color>{
    50: Color(0xFFE9E6EE),
    100: Color(0xFFC7C0D6),
    200: Color(0xFFA296BA),
    300: Color(0xFF7C6C9E),
    400: Color(0xFF604D8A),
    500: Color(darkPrimaryPrimaryValue),
    600: Color(0xFF3E286D),
    700: Color(0xFF352262),
    800: Color(0xFF2D1C58),
    900: Color(0xFF1F1145),
  });
  static const int darkPrimaryPrimaryValue = 0xFF442D75;

  static const List<Color> randomColors = [
    Color(0xffEE6F57),
    Color(0xffFFC444),
    Color(0xff48A7FF),
    Color(0xffA2C345),
    Color(0xff0BE2B0),
    Color(0xffF44611),
    Color(0xff474A51),
  ];
}
