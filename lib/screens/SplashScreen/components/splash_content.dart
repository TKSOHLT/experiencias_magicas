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
              MediaQuery.of(context).size.height - 77), // Altura de la pantalla
          width: getProportionateScreenHeight(
              MediaQuery.of(context).size.width), // Ancho de la pantalla

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: getProportionateScreenHeight(200),
                width: getProportionateScreenHeight(
                    MediaQuery.of(context).size.width),
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
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
