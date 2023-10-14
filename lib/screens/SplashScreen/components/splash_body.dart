import 'dart:async';

import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    // Timer(
    //     const Duration(seconds: 4),
    //     () => Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(
    //             builder: (BuildContext context) => SignInScreen(),
    //           ),
    //           //funcion que limpia la pila de rutas anteriores
    //           (route) => false,
    //         ));
  }

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Esto es un test pa ver como es que se ve esta cosa jsjsjs.",
      "image": "assets/images/splash_1.jpeg",
    },
    {
      "text": "Esto es un test pa ver como es que se ve esta cosa jsjsjs.",
      "image": "assets/images/splash_2.jpeg",
    },
    {
      "text": "Esto es un test pa ver como es que se ve esta cosa jsjsjs.",
      "image": "assets/images/splash_3.jpeg"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
