import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeGenerator {
  static late ThemeGenerator _instance;

  ThemeGenerator._();

  factory ThemeGenerator() {
    return _instance;
  }
  static void init() {
    _instance = ThemeGenerator._();
  }

  Color get grayBorder => const Color(0xffdcdfd0);
  Color get sliderGradientBlue => const Color(0xff3e5d9a);
  Color get sliderGradientPurple => const Color(0xff76407e);
  Color get red => const Color(0xffDC392D);
  Color get lightGrey => const Color(0xffe8f4fc);
  Color get mustardYellow => const Color(0x00ffb81c);
  Color get darkBlue => const Color(0xff13294B);

  bool get isDarkMode =>
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  TextStyle h1XL = const TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Color(0xff13294B));
  TextStyle h1Header = const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Color(0xff13294B)); // onboarding
  TextStyle h2Header = const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Color(0xff13294B)); //
  TextStyle h3Header = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Color(0xff13294B)); //profile
  TextStyle h4Header = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Color(0xff13294B)); //
  TextStyle h5Header = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Color(0xff13294B)); //
  TextStyle h6Header = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Color(0xff13294B)); //
  TextStyle h7Header = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Color(0xff13294B)); //

  TextStyle eyebrows = const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Color(0xff13294B));

  TextStyle eyebrows_1 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
      color: Color(0xff13294B)); // section titles and sticky nav

  TextStyle bodyCopy_24 = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xff13294B));
  TextStyle bodyCopy_22 = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xff13294B));
  TextStyle bodyCopy_20 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xff13294B));
  TextStyle bodyCopy_16 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xff13294B));
  TextStyle bodyCopy_17 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xFFBDBDBD));
  TextStyle bodyCopy_14 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xff13294B));
  TextStyle bodyCopy_12 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xff13294B));

  TextStyle bodyCopy_10 = const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xff13294B));

  // Font size for buttons title
  static double get defaultButtonTitleFontSize => 16.0;

  // font size for xl button font sizes
  static double get defaultXlButtonTitleFontSize => 20.0;

  // font size for xl button font sizes
  static double get defaultSmallButtonTitleFontSize => 12.0;

  /*
  * Find my account font sizes
  */
  static double fmaTitleFontSize = 36.0;
  static double fmaTextFontSize = 14.0;
  static double fmaButtonFontSize = 16.0;
  static double fmaTandCFontSize = 12.0;
  static double fmaDescWordspacing = 1.0;

  /*
  * Forgot Username/Password
  */
  static double fupTitleFontSize = 36.0;
  static double fupTextFontSize = 14.0;
  static double fupButtonFontSize = 16.0;
  static double fupDescWordspacing = 0.5;

/*
*account setting additional card activation
 */
  static double asadditionalcardTextFontSize = 15.0;
  static double asadditionalcardWordspacing = 1.0;
  static double asadditionalcardButtonFontSize = 16.0;

  /*
  * New Card Activation Account Settings
   */
  static double ncaTitleFontSize = 36.0;
  static double ncaTextFontSize = 14.0;
  static double ncaButtonFontSize = 16.0;
  static double ncaTandCFontSize = 12.0;
  static double ncaDescWordspacing = 1.0;

  /*
  Additional card activation
  */
  static double acaTextFontSize = 15.0;
  static double acaWordspacing = 1.0;
  static double acaButtonFontSize = 16.0;
}

// "sea_foam":"#59BEC9",
// "dark_ocean":"#13294B",
// "sea_spray":"#B1E4E3",
// "sea_weed":"#1C8195",
// "cerulean":"#007DBA",
// "wine":"#7A4282",
// "pantone_179_C":"#E03C31",
// "mustard":"#FFB81c",
// "white":"#FFFFFF",
// "pantone_427_C":"#D0D3D4",
// "pantone_428_C":"#C1C6C8",
// "pantone_429_C":"#A2AAAD",
// "pantone_430_C":"#7C878E",
// "pantone_432_C":"#333F48",
// "pantone_433_C":"#1D252D",
// "web_gray_1":"#F4F5F5",
// "web_gray_2":"#DCDEF0"
