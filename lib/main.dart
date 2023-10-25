

import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/routes.dart';
import 'package:experiencias_magicas/screens/splash/splash.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:experiencias_magicas/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],

      color: kPrimaryColor,
      debugShowCheckedModeBanner: false,
      title: 'Test',
      theme: AppTheme.lightTheme(context),
      initialRoute: ruta,
      routes: routes,
    );
  }
}
