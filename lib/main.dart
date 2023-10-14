import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/routes.dart';
import 'package:experiencias_magicas/screens/SplashScreen/splash.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:experiencias_magicas/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String ruta = SplashScreen.routeName;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp(
      color: kPrimaryColor,
      debugShowCheckedModeBanner: false,
      title: 'Test',
      theme: AppTheme.lightTheme(context),
      initialRoute: ruta,
      routes: routes,
    );
  }
}
