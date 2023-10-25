import 'package:experiencias_magicas/screens/splash/components/splash_content.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Esto es un test pa ver como es que se ve esta cosa jsjsjs.",
      "image": "assets/images/splash_1.jpeg",
    },
    {
      "text": "Esta es la pantalla 2.",
      "image": "assets/images/splash_2.jpeg",
    },
    {"text": "La pantalla 3 padrino", "image": "assets/images/splash_3.jpeg"}
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
                itemBuilder: (context, currentPage) => SplashContent(
                  image: splashData[currentPage]["image"],
                  text: splashData[currentPage]['text'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
