
import 'package:experiencias_magicas/screens/splash/splash.dart';
import 'package:experiencias_magicas/screens/superhome/superhome.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SuperHomeScreen.routeName: (context) => SuperHomeScreen(),
};
