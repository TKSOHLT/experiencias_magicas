import 'package:experiencias_magicas/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover, // La imagen cubrirá todo el contenedor
              ),
            ),
            height: getProportionateScreenHeight(
                MediaQuery.of(context).size.height * 0.902), // Altura de la pantalla
            width: getProportionateScreenHeight(
                MediaQuery.of(context).size.width), // Ancho de la pantalla

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Icon(Icons.arrow_forward_ios_rounded,
                //         color: Color.fromARGB(111, 255, 255, 255), size: 100)
                //   ],
                // ),
                SizedBox(height: getProportionateScreenHeight(200)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      // height: getProportionateScreenHeight(100),
                      width: getProportionateScreenHeight(
                          MediaQuery.of(context).size.width - 40),
                      child: Column(
                        children: [
                          Text("Test", style: splashStyle1),
                          SizedBox(
                            width: getProportionateScreenWidth(300),
                            child: const Divider(
                              height: 10,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            text!,
                            textAlign: TextAlign.center,
                            style: splashStyle2,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    if (image == "assets/images/splash_3.jpeg") ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen(),
                                ),
                                //funcion que limpia la pila de rutas anteriores
                                (route) => false,
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                            color: Colors.white,
                            iconSize: 80,
                          )
                        ],
                      )
                    ] else ...[
                      SizedBox(
                        height: getProportionateScreenHeight(70),
                      )
                    ]
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
