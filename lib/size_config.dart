import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;
  static late double fontSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    fontSize = _mediaQueryData.textScaleFactor;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// Get el tamaño de fuente proporcional
double getProportionateFontSize(double inputFontSize) {
  double fontSize = SizeConfig.fontSize;

  switch (fontSize) {
    case 0.85:
      return inputFontSize + 2;
    case 1.0:
      return inputFontSize;
    case 1.15:
      return inputFontSize - 2;
    case 1.3:
      return inputFontSize - 4;
    default:
      return inputFontSize;
  }
}
